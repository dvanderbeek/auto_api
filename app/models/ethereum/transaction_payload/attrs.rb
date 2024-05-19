module Ethereum
  class TransactionPayload
    class Attrs
      def self.valid
        {
          id: 1,
          created_at: Time.current,
          updated_at: Time.current,
          serialized: '0x0000000000000000',
          signing_payload: '0x0000000000000000',
        }
      end
    end
  end
end
