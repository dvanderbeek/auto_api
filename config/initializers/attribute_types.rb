# Extending built-in types with example values for docs
module ActiveRecord
  module Type
    class Text
      def example
        <<~TEXT
          Lorem ipsum dolor sit amet, consectetur adipiscing elit,
          sed do eiusmod tempor incididunt ut labore et dolore magna
          aliqua. Ut enim ad minim veniam, quis nostrud exercitation
          ullamco laboris nisi ut aliquip ex ea commodo consequat.
          Duis aute irure dolor in reprehenderit in voluptate velit
          esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
          occaecat cupidatat non proident, sunt in culpa qui officia
          deserunt mollit anim id est laborum.
        TEXT
      end
    end
  end
end

module ActiveModel
  module Type
    class String
      def example
        "example_value"
      end
    end

    class Integer
      def example
        100
      end
    end

    class DateTime
      def example
        '2024-06-08T14:33:47Z'
      end
    end
  end
end

# Adding custom types with more specific example values that can be used across resources

class UuidType < ActiveModel::Type::String
  def example
    '267f5e67-0311-490a-b776-06e5075123b0'
  end
end

class TransactionPayloadType < ActiveModel::Type::String
  def example
    'hex-encoded-transaction-payload'
  end
end

class TransactionHashType < ActiveModel::Type::String
  def example
    'hex-encoded-transaction-hash'
  end
end

class ProtocolType < ActiveModel::Type::String
  def example
    'ethereum'
  end
end

class NetworkType < ActiveModel::Type::String
  def example
    'mainnet'
  end
end

ActiveRecord::Type.register(:uuid, UuidType)
ActiveModel::Type.register(:uuid, UuidType)

ActiveRecord::Type.register(:transaction_payload, TransactionPayloadType)
ActiveModel::Type.register(:transaction_payload, TransactionPayloadType)

ActiveRecord::Type.register(:transaction_hash, TransactionHashType)
ActiveModel::Type.register(:transaction_hash, TransactionHashType)

ActiveRecord::Type.register(:protocol, ProtocolType)
ActiveModel::Type.register(:protocol, ProtocolType)

ActiveRecord::Type.register(:network, NetworkType)
ActiveModel::Type.register(:network, NetworkType)
