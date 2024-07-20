module Transactions
  class Broadcast < VirtualRecord
    attribute :protocol, :string
    attribute :network, :string
    attribute :signed_transaction_payload, :transaction_payload
    attribute :transaction_hash, :string

    validates :protocol, :network, :signed_transaction_payload, presence: true

    def transaction_hash
      return unless protocol && network

      SlateNetworks::Client.for(protocol, network).broadcast(signed_transaction_payload)
    end

    def self.permitted_attributes
      %w[protocol network signed_transaction_payload]
    end
  end
end
