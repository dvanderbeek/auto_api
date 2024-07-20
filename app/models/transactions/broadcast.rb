module Transactions
  class Broadcast < VirtualRecord
    include HasClient

    validates :protocol, inclusion: { in: %w[near ethereum solana], message: 'is not currently supported' }

    attribute :protocol, :string
    attribute :network, :string
    attribute :signed_transaction_payload, :transaction_payload
    attribute :transaction_hash, :string

    validates :protocol, :network, :signed_transaction_payload, presence: true

    def self.permitted_attributes
      %w[protocol network signed_transaction_payload]
    end

    def transaction_hash
      client&.broadcast(signed_transaction_payload)
    end
  end
end
