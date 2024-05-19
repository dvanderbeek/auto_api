FactoryBot.define do
  factory :ethereum_transaction_payload, class: 'Ethereum::TransactionPayload' do
    serialized { "MyString" }
    signing_payload { "MyString" }
  end
end
