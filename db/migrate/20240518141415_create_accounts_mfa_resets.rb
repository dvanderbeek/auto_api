class CreateAccountsMfaResets < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts_mfa_resets do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
