module SlateNetworks
  class SolanaClient < Client
    def sign(payload, private_key)
      "solana-#{network}-signed-tx-payload"
    end

    def broadcast(payload)
      "solana-#{network}-tx-hash"
    end
  end
end
