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
    before do
      allow(NameApiClient).to receive(:new).and_return(instance_double('NameApiClient', get_name: 'david'))
    end

    it 'populates the name attribute' do
      user = FactoryBot.create(:accounts_user, name: nil, autopopulated: true)
      expect(user.name).to eq NameApiClient.new.get_name(user)
    end
  end
end
