module SlateNetworks
  class EthereumClient < Client
    def sign(payload, private_key)
      "ethereum-#{network}-signed-tx-payload"
    end

    def broadcast(payload)
      "ethereum-#{network}-tx-hash"
    end

    def generate_transaction(input)
      "ethereum-#{network}-unsigned-tx-payload"
    end
  end
end
