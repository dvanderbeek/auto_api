class PetStore::ProfilePhotoSerializer < ActiveModel::Serializer
  attributes :id, :url, :pet
end
