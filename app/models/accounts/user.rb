module Accounts
  class User < ApplicationRecord
    include Autopopulateable

    attribute :validated, :boolean, default: true
    validates :name, name: true

    # autopopulates :name, with: ->(user) { puts 'Fetching name from remote API'; 'david' }
    autopopulates :name, with: :fetch_my_name

    def fetch_my_name
      puts 'Fetching value from remote API'
      'DVDB'
    end
  end
end
