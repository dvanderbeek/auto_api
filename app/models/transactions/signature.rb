module Transactions
  class Signature < VirtualRecord
    attribute :protocol, :string
    attribute :network, :string
    attribute :unsigned_transaction_payload, :transaction_payload
    attribute :private_key, :string
    attribute :signed_transaction_payload, :transaction_payload

    def signed_transaction_payload
      "SIGNED WITH SLATE_NETWORKS OR RPC CLIENT"
    end

    def self.permitted_attributes
      %w[protocol network unsigned_transaction_payload private_key]
    end
  end
end
