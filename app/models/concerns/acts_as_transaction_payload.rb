module ActsAsTransactionPayload
  extend ActiveSupport::Concern

  included do
    include HasClient

    attribute :payload, :transaction_payload

    def payload
      client&.generate_transaction(self)
    end

    def protocol
      self.class.module_parent.name.underscore
    end

    def transaction_type
      self.class.name.demodulize.underscore
    end

    def serializer_class
      Transactions::UnsignedPayloadSerializer
    end
  end
end
