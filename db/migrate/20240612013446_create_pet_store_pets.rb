class CreatePetStorePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_store_pets do |t|
      t.string :name

      t.timestamps
    end
  end
end
