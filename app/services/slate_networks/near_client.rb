module SlateNetworks
  class NearClient < Client
    def sign(payload, private_key)
      "near-#{network}-signed-tx-payload"
    end

    def broadcast(payload)
      "near-#{network}-tx-hash"
    end
  end
end
