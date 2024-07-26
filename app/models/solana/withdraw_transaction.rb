module Solana
  class WithdrawTransaction < VirtualRecord
    include ActsAsTransactionPayload

    attribute :funding_account_pubkey, :string
    attribute :amount_lamports, :integer
    attribute :stake_account_pubkey, :string

    validates :amount_lamports, :funding_account_pubkey, :stake_account_pubkey, presence: true

    def self.permitted_attributes
      %w[network funding_account_pubkey amount_lamports stake_account_pubkey]
    end

    # TODO: Figure out how to generate a single Type for this in OpenApi / GQL, shared with other transaction types

    # also, instead of having a separate client class with tons of different requests, it may make sense to just make this class aware of how
    # to make a single request to slate-networks or whatever RPC it needs
    # def payload
    #   "withdraw-#{amount_lamports}-lamports-from-#{stake_account_pubkey}-on-#{network}"
    # end
  end
end
