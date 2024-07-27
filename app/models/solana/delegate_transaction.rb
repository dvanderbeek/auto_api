module Solana
  class DelegateTransaction < VirtualRecord
    include ActsAsTransactionPayload

    attribute :funding_account_pubkey, :string
    attribute :amount_lamports, :integer
    attribute :vote_account_pubkey, :string

    attribute :stake_account_pubkey, :string

    def self.permitted_attributes
      %w[network funding_account_pubkey amount_lamports vote_account_pubkey]
    end

    def payload
      txn_data&.dig :transactionPayload
    end

    def stake_account_pubkey
      txn_data&.dig :stakeAccountPubkey
    end

    private

    def txn_data
      @txn_data ||= client&.post(
        '/delegate_transaction',
        attributes, # This would be the inputs for the api call
        # here i'm just mocking the response I want to get back
        {
          transactionPayload: "delegate-#{amount_lamports}-lamports-to-#{vote_account_pubkey}-on-#{network}",
          stakeAccountPubkey: 'my-stake-account-pubkey'
        }
      )
    end
  end
end
