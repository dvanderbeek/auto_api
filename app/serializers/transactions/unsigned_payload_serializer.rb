class Transactions::UnsignedPayloadSerializer < ActiveModel::Serializer
  attributes :payload
  attribute :stake_account_pubkey, if: :solana_delegate_transaction?

  def solana_delegate_transaction?
    object.protocol == 'solana' &&
      object.transaction_type == 'delegate_transaction'
  end
end
