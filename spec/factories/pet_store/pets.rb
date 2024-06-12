FactoryBot.define do
  factory :pet_store_pet, class: 'PetStore::Pet' do
    name { "MyString" }
  end
end
