module Solana
  class UndelegateTransaction < VirtualRecord
    include ActsAsTransactionPayload

    attribute :funding_account_pubkey, :string
    attribute :stake_account_pubkey, :string

    def self.permitted_attributes
      %w[network funding_account_pubkey stake_account_pubkey]
    end

    # TODO: Figure out how to generate a single Type for this in OpenApi / GQL, shared with other transaction types
  end
end
