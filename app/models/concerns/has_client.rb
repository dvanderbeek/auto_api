module HasClient
  extend ActiveSupport::Concern

  included do
    attr_writer :client
  end

  def client
    @client || SlateNetworks::Client.for(protocol, network)
  end
end
