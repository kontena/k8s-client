require 'time'

module K8s
  class Type
    def initialize(default = nil)
      @default = nil
    end

    def __value(input = nil)
      coerce(input.nil? ? default : input)
    end

    def coerce(input)
      input.nil? ? default : input
    end

    def default
      return @default.call if @default.respond_to?(:call)
      return @default.dup if @default.respond_to?(:dup)

      @default
    end

    class String < Type
      def coerce(input)
        input.nil? ? nil : input.to_s
      end
    end

    class DateTime < Type
      def coerce(input)
        input.nil? ? nil : ::DateTime.parse(input)
      end
    end

    class Hash < Type
      def self.of(type)
        klass = Class.new(Hash) do
          def self.child_class
            @child_class
          end
        end
        klass.instance_variable_set(:@child_class, type)
        klass
      end

      def coerce(input)
        if self.class.respond_to?(:child_class)
          return ::Hash[*input.to_h.map { |key, value| self.class.child_class.new(value) }].extend(K8s::HashStruct::ArrayHelper)
        end

        K8s::HashStruct.new(input)
      end
    end

    class Array < Type
      def self.of(type)
        klass = Class.new(Array) do
          def self.child_class
            @child_class
          end
        end
        klass.instance_variable_set(:@child_class, type)
        klass
      end

      def coerce(input)
        if self.class.respond_to?(:child_class)
          return input.to_a.map { |item| self.class.child_class.new(item) }.extend(K8s::HashStruct::ArrayHelper)
        end

        input.to_a.extend(K8s::HashStruct::ArrayHelper)
      end
    end

    class Integer < Type
      def coerce(input)
        input.nil? ? nil : input.to_i
      end
    end

    class Bool < Type
      def coerce(input)
        case input
        when ::String
          input.match?(/^(true|y(?:es)?|1|enabled?)$/)
        when ::Integer
          input == 1
        when ::Float
          input >= 1.0
        else
          !!input
        end
      end
    end

    class Float
      def coerce(input)
        input.nil? ? input : input.to_f
      end
    end
  end
end
