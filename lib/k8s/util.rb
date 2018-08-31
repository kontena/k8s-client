module K8s
  # Miscellaneous helpers
  module Util
    # Yield with all non-nil args, returning matching array with corresponding return values or nils.
    #
    # Args must be usable as hash keys. Duplicate args will all map to the same return value.
    #
    # @param args [Array<nil, Object>]
    # @yield args
    # @yieldparam args [Array<Object>] omitting any nil values
    # @return [Array<nil, Object>] matching args array 1:1, containing yielded values for non-nil args
    def self.compact_map(args)
      func_args = args.compact

      values = yield func_args

      # Hash{arg => value}
      value_map = Hash[func_args.zip(values)]

      args.map{|arg| value_map[arg] }
    end

    # Produces a set of json-patch operations so that applying
    # the operations on a, gives you the results of b
    # Used in correctly patching the Kube resources on stack updates
    #
    # @param a [Hash] Hash to compute patches against
    # @param a [Hash] New Hash to compute patches "from"
    def self.json_patch(a, b)
      diffs = HashDiff.diff(a, b, array_path: true)
      ops = []
      # Each diff is like ["+", "spec.selector.aziz", "kebab"]
      # or ["-", "spec.selector.aziz", "kebab"]
      diffs.each do |diff|
        operator, path, value = nil
        operator = diff[0]
        # substitute '/' with '~1' and '~' with '~0'
        # according to RFC 6901
        path = diff[1].map {|p| p.to_s.gsub('/', '~1')}.map {|p| p.to_s.gsub('~', '~0')}
        if operator == '-'
          ops << {
            op: "remove",
            path: "/" + path.join('/')
          }
        elsif operator == '+'
          ops << {
            op: "add",
            path: "/" + path.join('/'),
            value: diff[2]
          }
        elsif operator == '~'
          ops << {
            op: "replace",
            path: "/" + path.join('/'),
            value: diff[3]
          }
        else
          raise "WTF, unknown diff operator: #{operator}!"
        end

      end

      ops
    end
  end
end
