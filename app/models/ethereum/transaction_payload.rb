class Ethereum::TransactionPayload < ApplicationRecord
  attribute :serialized, :transaction_payload
  attribute :signing_payload, :string

  before_create do
    self.serialized = '0x-serialized-payload-from-nodejs-service'
    self.signing_payload = '0x-signing-payload-from-nodejs-service'
  end
end
