module Ethereum
  class ExampleTransaction < ::VirtualRecord
    attribute :contract_name, :string
    attribute :contract_method, :string
    attribute :payload, :transaction_payload

    restrict :payload
  end
end
