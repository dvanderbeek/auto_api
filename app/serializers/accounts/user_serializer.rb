class Accounts::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
