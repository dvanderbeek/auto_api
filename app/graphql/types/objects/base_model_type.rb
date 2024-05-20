require 'factory_bot'

module Types
  module Objects
    class BaseModelType < Types::BaseObject
      class GqlType
        attr_reader :type

        def initialize(type)
          @type = type
        end

        def to_gql
          case type
          when :string, :text then GraphQL::Types::String
          when :integer then GraphQL::Types::BigInt
          when :datetime then GraphQL::Types::ISO8601DateTime
          end
        end
      end

      def self.create_type(model)
        Class.new(Types::BaseObject) do
          graphql_name "#{model.name.gsub('::', '')}Type"
          description "A dynamically generated type for #{name}"

          serializer = ActiveModelSerializers::SerializableResource.new(model.new)
          attrs = serializer.serializable_hash.keys

          attrs.each do |attr, value|
            column = model.columns.find { |c| c.name.to_s == attr.to_s }
            type = model.type_for_attribute(attr.to_sym).type

            field attr.to_sym, GqlType.new(type).to_gql, null: (column&.null || true)
          end
        end
      end
    end
  end
end
