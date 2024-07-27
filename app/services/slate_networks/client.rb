module SlateNetworks
  class Client
    include ActiveModel::Model

    attr_accessor :protocol, :network

    def self.for(protocol, network)
      return unless protocol && network

      "SlateNetworks::#{protocol.camelize}Client".constantize.new({ protocol:, network: })
    end

    def sign(*)
      raise NotImplementedError, 'subclasses must implement sign'
    end

    def broadcast(*)
      raise NotImplementedError, 'subclasses must implement broadcast'
    end

    def post(_path, _input, resp)
      resp
    end
  end
end
