# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    Dir[Rails.root + 'app/models/**/*.rb'].each do |path|
      require path
    end

    ApplicationRecord.descendants.each do |model|
      namespace, name = model.name.split('::')

      next unless model.setup_complete?

      type_class = Types::Objects::BaseModelType.create_type(model)

      field model.table_name.to_sym, [type_class], null: false do
        description "Returns a list of #{namespace} #{name.pluralize}"
      end

      # TODO: If needed, could do this via a service layer
      define_method(model.table_name) do
        model.all
      end
    end
  end
end
