module Mutations
  class DynamicMutation < BaseMutation
    def self.create_mutation(model, action)
      Class.new(Mutations::DynamicMutation) do
        graphql_name "#{model.name.gsub('::', '')}#{action.capitalize}"
        types = Types::Objects::BaseModelType.register(model)

        argument :id, type: GraphQL::Types::BigInt if %w[update delete].include?(action)
        argument :input, types[:input_type], required: true unless action == 'delete'

        field :result, types[:type], null: false

        define_method :resolve do |args|
          resource = action == 'create' ? model.new : model.find(args[:id])
          resource.assign_attributes(**args[:input]) unless action == 'delete'

          raise GraphQL::ExecutionError.new(resource.errors.full_messages.join(', ')) unless (action == 'delete' ? resource.destroy : resource.save)

          { result: resource }
        end
      end
    end
  end
end
