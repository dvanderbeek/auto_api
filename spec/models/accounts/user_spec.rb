require 'rails_helper'

RSpec.describe Accounts::User do
  let(:user) { FactoryBot.build(:accounts_user) }

  context 'when the user is not validated via remote API' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  context 'when the user is validated via remote API' do
    it 'is not valid' do
      user.validated = true
      expect(user).not_to be_valid
    end
  end

  describe 'autopopulated' do
    it 'populates the name attribute' do
      user = FactoryBot.create(:accounts_user, name: nil, autopopulated: true)
      expect(user.name).to eq user.fetch_my_name
    end
  end
end
