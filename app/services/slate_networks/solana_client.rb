module SlateNetworks
  class SolanaClient < Client
    def sign(payload, private_key)
      "solana-#{network}-signed-tx-payload"
    end

    def broadcast(payload)
      "solana-#{network}-tx-hash"
    end

    def generate_transaction(input)
      "solana-#{network}-unsigned-tx-payload-#{input.class.name.demodulize.gsub('Transaction', '').underscore}"
    end
  end
end
