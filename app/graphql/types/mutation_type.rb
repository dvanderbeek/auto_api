# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    (ApplicationRecord.descendants + VirtualRecord.descendants).each do |model|
      # TODO: Add method similar to `restful_action` to disable certain mutations, and default to only create for VirtualRecord descendants
      field :"#{model.name.gsub('::', '').underscore}_create", mutation: Mutations::DynamicMutation.create_mutation(model, 'create') if model.available_restful_actions.include?(:create)
      field :"#{model.name.gsub('::', '').underscore}_update", mutation: Mutations::DynamicMutation.create_mutation(model, 'update') if model.available_restful_actions.include?(:update)
      field :"#{model.name.gsub('::', '').underscore}_delete", mutation: Mutations::DynamicMutation.create_mutation(model, 'delete') if model.available_restful_actions.include?(:destroy)
    end
  end
end
