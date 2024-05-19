require 'factory_bot'

module Types
  module Objects
    class BaseModelType < Types::BaseObject
      class ValueType
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def type
          if value.is_a?(Integer)
            GraphQL::Types::BigInt
          elsif value.is_a?(String)
            GraphQL::Types::String
          elsif value.is_a?(DateTime) || value.is_a?(Time)
            GraphQL::Types::ISO8601DateTime
          end
        end
      end

      def self.create_type(model)
        Class.new(Types::BaseObject) do
          graphql_name "#{model.name.gsub('::', '')}Type"
          description "A dynamically generated type for #{name}"

          serializer = ActiveModelSerializers::SerializableResource.new(model.example)
          attrs = serializer.serializable_hash

          attrs.each do |attr, value|
            column = model.columns.find { |c| c.name.to_s == attr.to_s }

            field attr.to_sym, ValueType.new(value).type, null: (column&.null || true)
          end
        end
      end
    end
  end
end
