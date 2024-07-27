module Solana
  class UndelegateTransaction < VirtualRecord
    include ActsAsTransactionPayload

    attribute :funding_account_pubkey, :string
    attribute :stake_account_pubkey, :string

    def self.permitted_attributes
      %w[network funding_account_pubkey stake_account_pubkey]
    end

    def undelegate_transaction(input)
      client&.post(
        '/undelegate_transaction',
        attributes,
        "undelegate-from-#{input.stake_account_pubkey}-on-#{network}"
      )
    end
  end
end
