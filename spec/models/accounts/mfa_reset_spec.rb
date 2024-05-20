require 'rails_helper'

RSpec.describe Accounts::MfaReset do
  it 'logs a message as a side effect' do
    mfa_reset = described_class.example

    output = StringIO.new
    Rails.logger = Logger.new(output)

    mfa_reset.save

    expect(output.string.strip).to include("RESETTING MFA FOR USER #{mfa_reset.user_id}")
  end
end
