class Transactions::SignatureSerializer < ActiveModel::Serializer
  attributes :signed_transaction_payload
end
