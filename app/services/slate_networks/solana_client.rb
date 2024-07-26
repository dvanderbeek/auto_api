module SlateNetworks
  class SolanaClient < Client
    def sign(payload, private_key)
      "solana-#{network}-signed-tx-payload"
    end

    def broadcast(payload)
      "solana-#{network}-tx-hash"
    end

    def generate_transaction(input)
      send input.transaction_type, input
    end

    def delegate_transaction(input)
      "delegate-#{input.amount_lamports}-lamports-to-#{input.vote_account_pubkey}-on-#{network}"
    end

    def undelegate_transaction(input)
      "undelegate-from-#{input.stake_account_pubkey}-on-#{network}"
    end

    def withdraw_transaction(input)
      "withdraw-#{input.amount_lamports}-lamports-from-#{input.stake_account_pubkey}-on-#{network}"
    end
  end
end
