module HasClient
  extend ActiveSupport::Concern

  included do
    attr_writer :client

    attribute :protocol, :protocol
    attribute :network, :network
  end

  def client
    @client || SlateNetworks::Client.for(protocol, network)
  end
end
