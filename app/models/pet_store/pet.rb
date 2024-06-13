class PetStore::Pet < ApplicationRecord
  has_one :profile_photo

  delegate :url, to: :profile_photo, prefix: true, allow_nil: true

  attribute :profile_photo_url, :string

  # TODO: maybe use accepts_netsted_attributes_for since this attr is on an associated model
  restrict :profile_photo_url
end
