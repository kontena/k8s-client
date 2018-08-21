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
  end
end
