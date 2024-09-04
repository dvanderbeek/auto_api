FactoryBot.define do
  factory :accounts_user, class: 'Accounts::User' do
    autopopulated { false }
    validated { false }
    name { 'David' }
    email { 'email@example.com' }
  end
end
