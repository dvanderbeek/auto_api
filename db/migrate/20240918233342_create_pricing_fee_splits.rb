class CreatePricingFeeSplits < ActiveRecord::Migration[7.1]
  def change
    create_table :pricing_fee_splits do |t|
      t.decimal :percentage
      t.string :payout_wallet_address
      t.belongs_to :agreement, null: false, foreign_key: { to_table: :pricing_agreements, on_delete: :cascade }

      t.timestamps
    end
  end
end
