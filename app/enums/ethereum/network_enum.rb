module Ethereum
  module NetworkEnum
    extend DeclarativeEnum

    key :network
    attr_type :network
    name 'EthereumNetwork'

    define do
      mainnet value: 'mainnet'
      holesky value: 'holesky'
    end
  end
end
