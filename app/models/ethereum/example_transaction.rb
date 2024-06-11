module Ethereum
  class ExampleTransaction < ::VirtualRecord
    attribute :contract_name, :string
    attribute :contract_method, :string
    attribute :payload, :transaction_payload

    def payload
      "SOME PAYLOAD FROM REMOTE API"
    end

    def self.permitted_attributes
      %w[contract_name contract_method]
    end
  end
end
