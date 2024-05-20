module Types
  module Objects
    class BaseModelType < Types::BaseObject
      @types = {}

      def self.register(model)
        type_name = "#{model.name.gsub('::', '')}Type"

        unless @types[type_name]
          @types[type_name] = create_type(model)
        end

        { type: @types[type_name] }
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

            field attr.to_sym, Types::GqlType.new(type).to_gql, null: (column&.null || true)
          end
        end
      end
    end
  end
end
