module Transactions
  class Signature < VirtualRecord
    include HasClient

    validates :protocol, inclusion: { in: %w[near ethereum solana], message: 'is not currently supported' }

    attribute :protocol, :string
    attribute :network, :string
    attribute :unsigned_transaction_payload, :transaction_payload
    attribute :private_key, :string
    attribute :signed_transaction_payload, :transaction_payload

    def self.permitted_attributes
      %w[protocol network unsigned_transaction_payload private_key]
    end

    def signed_transaction_payload
      client&.sign(unsigned_transaction_payload, private_key)
    end
  end
end
