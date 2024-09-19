FactoryBot.define do
  factory :pricing_agreement, class: 'Pricing::Agreement' do
    effective_fee_percentage { "9.99" }
  end
end
