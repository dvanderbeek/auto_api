class Ethereum::TransactionPayloadSerializer < ActiveModel::Serializer
  attributes :id, :serialized, :signing_payload
end
