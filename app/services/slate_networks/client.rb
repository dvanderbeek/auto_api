module SlateNetworks
  class Client
    include ActiveModel::Model

    attr_accessor :protocol, :network

    def self.for(protocol, network)
      klass = "SlateNetworks::#{protocol.classify}Client".constantize
      klass.new({ protocol:, network: })
    end

    def broadcast(*)
      raise NotImplementedError, 'subclasses must implement broadcast'
    end
  end
end
