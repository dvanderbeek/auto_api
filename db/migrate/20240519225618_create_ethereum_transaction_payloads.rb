class CreateEthereumTransactionPayloads < ActiveRecord::Migration[7.1]
  def change
    create_table :ethereum_transaction_payloads do |t|
      t.string :serialized
      t.string :signing_payload

      t.timestamps
    end
  end
end
