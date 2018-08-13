module K8s
  module Util
    # Yield with all non-nil args, returning matching array with corresponding return values or nils.
    # Args must be usable as hash keys.
    #
    # @return [Array] matching args
    def self.compact_yield(*args)
      func_args = args.compact

      values = yield *func_args

      # Hash{arg => value}
      value_map = Hash[func_args.zip(values)]

      args.map{|arg| value_map[arg] }
    end
  end
end
