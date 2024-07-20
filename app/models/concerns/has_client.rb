module HasClient
  extend ActiveSupport::Concern

  included do
    attr_writer :client
  end

  def client
    return unless protocol && network
    @client || SlateNetworks::Client.for(protocol, network)
  end
end
