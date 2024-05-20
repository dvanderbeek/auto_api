module Mutations
  class DynamicMutation < BaseMutation
    def self.create_mutation(model, action)
      Class.new(Mutations::DynamicMutation) do
        graphql_name "#{model.name.gsub('::', '')}#{action.capitalize}"
        types = Types::Objects::BaseModelType.register(model)

        argument :id, type: GraphQL::Types::BigInt if action == 'update'
        argument :input, types[:input_type], required: true
        # input_object_class types[:input_type]

        field :result, types[:type], null: false

        define_method :resolve do |args|
          resource = action == 'create' ? model.new(**args[:input]) : model.find(args[:id])
          resource.assign_attributes(**args[:input]) unless action == 'create'
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
