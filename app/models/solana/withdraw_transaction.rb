module Solana
  class WithdrawTransaction < VirtualRecord
    include ActsAsTransactionPayload

    attribute :funding_account_pubkey, :string
    attribute :amount_lamports, :integer
    attribute :stake_account_pubkey, :string

    def self.permitted_attributes
      %w[network funding_account_pubkey amount_lamports stake_account_pubkey]
    end

    def save(*)
      super(*)
      # Rails.logger.info "CREATE OTHER AR MODEL IN DATABSE"

    end

    # TODO: Figure out how to generate a single Type for this in OpenApi / GQL, shared with other transaction types
    # Right now it has a separate type for each of thse Transaction classes, but they all use the same serializer and just have the `payload` attr
    def payload
      client&.post(
        '/withdraw_transaction',
        attributes,
        "withdraw-#{amount_lamports}-lamports-from-#{stake_account_pubkey}-on-#{network}"
      )
    end
  end
end
