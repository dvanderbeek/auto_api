module Accounts
  class MfaReset < ApplicationRecord
    restful_actions :index, :show, :create

    validates :user_id, presence: true

    after_create do
      Rails.logger.info "RESETTING MFA FOR USER #{user_id}"
    end
  end
end
