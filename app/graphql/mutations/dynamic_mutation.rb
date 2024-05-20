module Mutations
  class DynamicMutation < BaseMutation
    def self.create_mutation(model, action)
      Class.new(Mutations::DynamicMutation) do
        graphql_name "#{model.name.gsub('::', '')}#{action.capitalize}"
        types = Types::Objects::BaseModelType.register(model)

        serializer = ActiveModelSerializers::SerializableResource.new(model.new)
        attrs = serializer.serializable_hash.keys

        attrs.each do |attr, value|
          type = model.type_for_attribute(attr.to_sym).type

          # TODO: introspect validations to see what attributes are required
          argument attr.to_sym, Types::GqlType.new(type).to_gql, required: false
        end

        field :result, types[:type], null: false

        define_method :resolve do |args|
          resource = action == 'create' ? model.new(**args) : model.find(input[:id])
          resource.assign_attributes(**args) unless action == 'create'
          if resource.save
            { result: resource }
          else
            raise GraphQL::ExecutionError.new(resource.errors.full_messages.join(', '))
          end
        end
      end
    end
  end
end
