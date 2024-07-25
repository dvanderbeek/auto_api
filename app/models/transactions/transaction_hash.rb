module Transactions
  class TransactionHash < VirtualRecord
    attribute :parent_type, :string
    attribute :parent_id, :uuid
    attribute :tx_hash, :transaction_hash

    def save(*)
      super && puts("saving transaction hash #{tx_hash} for #{parent_type}:#{parent_id}")
    end

    def self.permitted_attributes
      %w[parent_type parent_id tx_hash]
    end
  end
end
