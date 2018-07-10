module Pharos
  module Kube
    module YAML
      # recursively transform YAML keys to ruby attribute symbols
      def self.transform_keys(value)
        case value
        when Hash
          Hash[value.keys.map{|key|
            [key.gsub('-', '_').to_sym, transform_keys(value[key])]
          }]
        when Array
          value.map{|v| transform_keys(v)}
        else
          value
        end
      end

      # @param file [String] path
      # @return [Hash]
      def self.load_file(file)
        transform_keys(::YAML.load_file(file))
      end
    end
  end
end
