FactoryBot.define do
  factory :pet_store_profile_photo, class: 'PetStore::ProfilePhoto' do
    url { "MyString" }
    pet { nil }
  end
end
