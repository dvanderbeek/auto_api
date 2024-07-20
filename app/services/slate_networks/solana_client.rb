module SlateNetworks
  class SolanaClient < Client
    def broadcast(payload)
      "solana-#{network}-tx-hash"
    end
  end
end
