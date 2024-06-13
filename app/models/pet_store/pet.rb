class PetStore::Pet < ApplicationRecord
  has_one :profile_photo

  delegate :url, to: :profile_photo, prefix: true, allow_nil: true

  attribute :profile_photo_url, :string

  allow :name, on: [:create, :update]
  restrict :profile_photo_url
end
