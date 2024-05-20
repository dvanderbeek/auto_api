module Accounts
  class MfaReset < ApplicationRecord
    validates :user_id, presence: true

    after_create do
      Rails.logger.info "RESETTING MFA FOR USER #{user_id}"
    end
  end
end
