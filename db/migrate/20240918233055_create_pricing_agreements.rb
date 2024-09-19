class CreatePricingAgreements < ActiveRecord::Migration[7.1]
  def change
    create_table :pricing_agreements do |t|
      t.decimal :effective_fee_percentage

      t.timestamps
    end
  end
end
