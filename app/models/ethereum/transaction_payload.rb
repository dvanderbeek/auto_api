class Ethereum::TransactionPayload < ApplicationRecord
  before_create do
    self.serialized = '0x-serialized-payload-from-nodejs-service'
    self.signing_payload = '0x-signing-payload-from-nodejs-service'
  end
end
