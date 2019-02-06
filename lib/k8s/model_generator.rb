require 'json'
require 'fileutils'
require 'k8s/string_zoo'

module K8s
  class ModelGenerator
    using K8s::StringZoo

    PREFIX_PARTS = ['k8s', 'model'].freeze

    # @param swagger [Hash]
    def initialize(swagger)
      @swagger = swagger
    end

    # @return [Hash]
    def definitions
      @swagger['definitions']
    end

    # @return [Hash]
    def paths
      @swagger['paths']
    end

    def each_module(&block)
      modules = {}
      definitions.each do |name, definition|
        path = parse_name(name)[0...-1].map(&:snake_case).join('/') + '.rb'
        unless modules[path]
          modules[path] = true
          mod = name_to_module_path(name)
          contents = build_module(mod)

          yield path, contents
        end
      end
    end

    def build_module(name)
      padding = 2
      content = <<HEADER
# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

HEADER
      parts = name.split('::')[0...-1]
      parts.size.times.each do |i|
        mod_name = parts[i]
        content << <<PART
#{'  ' * (i +1)}module #{mod_name}
PART
      end
      parts.size.times.each do |i|
        content << <<PART
#{'  ' * (parts.size - i)}end
PART
      end
      content
    end

    def each_model(&block)
      definitions.each do |ref, definition|
        if definition['properties']
          model = build_model(ref, definition)
        elsif definition['type']
          model = build_type(ref, definition)
        else
          model = build_stub(ref, definition)
        end
        yield parse_name(ref).map(&:snake_case).join('/'), model
      end
    end

    def build_model(ref, definition)
      name = name_to_module_path(ref)
      registered_paths = build_model_registrations(ref)
      requires = build_requires(definition['properties'])
      properties = build_properties(definition['properties'] || {}, definition['required'] || [])

      model = <<MODEL
# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "#{name.split('::')[0...-1].map(&:snake_case).join('/')}"
#{requires.join("\n")}

module #{name.split('::')[0...-1].join('::')}
  class #{name.split('::').last} < K8s::TypedResource
    #{properties.map{ |p| p.join("\n    ") }.join("\n\n    ")}

    register_paths [
      #{registered_paths.map {|path| "'#{path}'" }.join(",\n      ")}
    ]
  end
end
MODEL

      model
    end

    def build_type(ref, definition)
      name = name_to_module_path(ref)
      registered_paths = build_model_registrations(ref)

      model = <<MODEL
# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "#{name.split('::')[0...-1].map(&:snake_case).join('/')}"

module #{name.split('::')[0...-1].join('::')}
  #{name.split('::').last} = K8s::API::Types::#{definition['type'].camel_case}
end
MODEL
      model
    end

    def build_stub(ref, definition)
      name = name_to_module_path(ref)
      registered_paths = build_model_registrations(ref)

      model = <<MODEL
# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "#{name.split('::')[0...-1].map(&:snake_case).join('/')}"

module #{name.split('::')[0...-1].join('::')}
  class #{name.split('::').last} < K8s::TypedResource; end
end
MODEL
      model
    end

    def build_model_registrations(ref)
      paths.select { |path, data|
        if data['get'] && responses = data['get']['responses']
          refs = responses.select do |k, v|
            if v.is_a?(Hash) && schema = v['schema']
              schema['$ref'] && schema['$ref'] == "#/definitions/#{ref}"
            end
          end
          refs.size > 0
        else
          false
        end
      }.keys
    end

    # @param properties [Hash]
    def build_requires(properties)
      properties.flat_map do |key, property|
        if property['$ref']
          name = parse_name(property['$ref'].split('#/definitions/io.k8s.')[1]).map(&:snake_case).join('/')
          "require '#{name}'"
        elsif property['items'] && property['items']['$ref']
          name = parse_name(property['items']['$ref'].split('#/definitions/io.k8s.')[1]).map(&:snake_case).join('/')
          "require '#{name}'"
        end
      end.compact.uniq
    end

    # @param properties [Hash]
    # @param required [Array<String>]
    # @return [Array<String>]
    def build_properties(properties, required)
      properties.map do |key, property|
        build_property(key, property, required.include?(key))
      end
    end

    # @param name [String]
    # @param property [Hash]
    # @param required [Array<String>]
    # @return [String]
    def build_property(name, property, required)
      type = property_type(property)
      type = map_type(type, property['items'])
      prop = []
      if property['description']
        property['description'].each_line do |line|
          prop << "# #{line}" unless line.strip.empty?
        end
      end
      prop << "# @return [#{type.sub(' | ', ',')}#{required ? '' : ',NilClass'}]"
      prop << "attribute :#{name.sub('$', '_')}, #{type}#{required ? '' : '.optional.default(nil)'}"
      prop
    end

    # @param name [String]
    # @return [String]
    def name_to_module_path(name)
      parse_name(name).map(&:camel_case).join('::')
    end

    # @param name [String]
    # @return [String]
    def parse_name(name)
      PREFIX_PARTS + name.sub("io.k8s.", "").sub(".pkg.", ".").split(".").map { |s| s.gsub('-', '_') }
    end

    # @param property [Hash]
    # @return [String]
    def property_type(property)
      if property['$ref']
        name_to_module_path(parse_ref(property['$ref']))
      else
        property['type']
      end
    end

    # @param ref [String]
    # @return [String]
    def parse_ref(ref)
      ref.split('#/definitions/io.k8s.')[1]
    end

    # @param type [String]
    # @param items [Hash, NilClass]
    # @return [String]
    def map_type(type, items)
      case type
      when 'object'
        'K8s::API::Types::Hash'
      when 'array'
        item_type = map_type(property_type(items), nil)
        "K8s::API::Types::Array.of(#{item_type})"
      when 'integer'
        'K8s::API::Types::Integer'
      when 'number'
        'K8s::API::Types::Integer'
      when 'string'
        'K8s::API::Types::String'
      when 'boolean'
        'K8s::API::Types::Bool'
      else
        type
      end
    end
  end
end
