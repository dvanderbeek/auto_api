class PetStore::Pet < ApplicationRecord
  has_one :profile_photo

  delegate :url, to: :profile_photo, prefix: true, allow_nil: true

  attribute :profile_photo_url, :string

  def self.permitted_attributes
    %w[name]
  end
end
