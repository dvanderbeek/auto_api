module Transactions
  class UnsignedPayload < VirtualRecord
    include HasClient

    validates :protocol, inclusion: { in: %w[near ethereum solana], message: 'is not currently supported' }

    # TODO: what's the best way to make these inputs dynamic depending on the specific transaction we are generating?
    # Maybe just subclasses with discrete API endpoints?

    # In the docs, we could use oneOf to handle different options for input schema
    # https://preview.readme.io/reference/post_anything-one-of-object

    # Maybe split into endpoint per protocol, with each type of txn (pretty limited within a protocol)
    # as a oneOf option
    attribute :contract_name, :string
    attribute :contract_method, :string
    attribute :payload, :transaction_payload

    def payload
      client&.generate_transaction(self)
    end

    def self.permitted_attributes
      %w[protocol network contract_name contract_method]
    end
  end
end
