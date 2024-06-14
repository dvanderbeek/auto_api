module Types
  module Objects
    class BaseModelType < Types::BaseObject
      @types = {}

      def self.register(model)
        type_name = "#{model.name.gsub('::', '')}Type"
        input_type_name = "#{model.name.gsub('::', '')}InputType"

        @types[type_name] ||= create_type(model, type_name)
        @types[input_type_name] ||= create_input_type(model, input_type_name)

        {
          type: @types[type_name],
          input_type: @types[input_type_name]
        }
      end

      def self.create_input_type(model, type_name)
        Class.new(Types::BaseInputObject) do
          graphql_name type_name
          description "A dynamically generated input type for #{name}"

          model.allowed_attributes(:create).keys.each do |attr|
            type = model.attribute_types[attr].type
            # TODO: introspect validations to see what attributes are required
            argument attr.to_sym, Types::GqlType.new(type).to_gql, required: false
          end
        end
      end

      def self.create_type(model, type_name)
        Class.new(Types::BaseObject) do
          graphql_name type_name
          description "A dynamically generated type for #{name}"

          serializer = ActiveModelSerializers::SerializableResource.new(model.new)
          attrs = serializer.serializable_hash.keys

          attrs.each do |attr, value|
            # TODO: introspect validations to see what attributes are required
            # column = model.columns.find { |c| c.name.to_s == attr.to_s }

            type_name = model.attribute_types[attr.to_s].type

            if type_name
              type = Types::GqlType.new(type_name).to_gql
            elsif type_name.nil? && associated_model = model.reflect_on_association(attr)&.klass
              type = Types::Objects::BaseModelType.register(associated_model)[:type]
            end
            next unless type

            field attr.to_sym, type, null: true #(column&.null || true)
          end
        end
      end
    end
  end
end
