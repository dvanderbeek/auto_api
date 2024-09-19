FactoryBot.define do
  factory :pricing_fee_split, class: 'Pricing::FeeSplit' do
    percentage { "9.99" }
    payout_wallet_address { "MyString" }
    pricing_agreement { nil }
  end
end
