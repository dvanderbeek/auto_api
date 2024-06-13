class PetStore::ProfilePhoto < ApplicationRecord
  belongs_to :pet

  restful_actions :create, :update

  allow :url, on: [:create, :update]
  allow :pet_id, on: :create

  # TODO: only allow pet_id on create;
  # TODO: Figure out scoping to current user
  def self.permitted_attributes
    %w[url pet_id]
  end

  # TODO: Include Pet in response, or make the response object be the associated Pet
end
