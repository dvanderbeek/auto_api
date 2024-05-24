# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    ApplicationRecord.descendants.each do |model|
      field :"#{model.name.gsub('::', '').underscore}_create", mutation: Mutations::DynamicMutation.create_mutation(model, 'create')
      field :"#{model.name.gsub('::', '').underscore}_update", mutation: Mutations::DynamicMutation.create_mutation(model, 'update')
      field :"#{model.name.gsub('::', '').underscore}_delete", mutation: Mutations::DynamicMutation.create_mutation(model, 'delete')
    end
  end
end
