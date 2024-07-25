module Solana
  class DelegateTransaction < ::Transactions::UnsignedPayload
    attribute :funding_account_pubkey, :string
    attribute :amount_lamports, :integer
    attribute :vote_account_pubkey, :string

    def protocol
      'solana'
    end

    def self.permitted_attributes
      %w[network funding_account_pubkey amount_lamports vote_account_pubkey]
    end
  end
end
