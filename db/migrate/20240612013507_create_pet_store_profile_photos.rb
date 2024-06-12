class CreatePetStoreProfilePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_store_profile_photos do |t|
      t.string :url
      t.belongs_to :pet, null: false, foreign_key: { to_table: 'pet_store_pets', on_delete: :cascade }

      t.timestamps
    end
  end
end
