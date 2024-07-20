module SlateNetworks
  class EthereumClient < Client
    def broadcast(payload)
      "ethereum-#{network}-tx-hash"
    end
  end
end
