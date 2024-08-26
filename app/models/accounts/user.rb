module Accounts
  class User < ApplicationRecord
    attribute :validated, :boolean, default: true
    validates :name, name: true

    autopopulates :name, with: ->(user) { NameApiClient.new.get_name(user) }
    # OTHER OPTIONS THAT WORK:
    # autopopulates :name, with: NameApiClient.new.method(:get_name)
    # autopopulates :name, with: :fetch_name

    # def fetch_name
    #   NameApiClient.new.get_name(self)
    # end
  end
end
