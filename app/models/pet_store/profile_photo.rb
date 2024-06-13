class PetStore::ProfilePhoto < ApplicationRecord
  belongs_to :pet

  restful_actions :create, :update

  allow :pet_id, on: :create

  # TODO: Include Pet in response, or make the response object be the associated Pet
end
