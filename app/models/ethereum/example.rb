module Ethereum
  class Example < ::VirtualRecord
    attribute :contract_name, :string
    attribute :contract_method, :string
    attribute :payload, :transaction_payload

    def payload
      "SOME PAYLOAD FROM REMOTE API"
    end
  end
end
