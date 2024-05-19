class Accounts::MfaResetSerializer < ActiveModel::Serializer
  attributes :id, :user_id
end
