class Accounts::MfaReset < ApplicationRecord
  validates :user_id, presence: true

  after_create do
    puts "RESETTING MFA FOR USER #{user_id}"
  end
end
