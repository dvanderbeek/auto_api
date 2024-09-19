class AddNameToPricingAgreements < ActiveRecord::Migration[7.1]
  def change
    add_column :pricing_agreements, :name, :string
  end
end
