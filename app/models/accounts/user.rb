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

    # TODO: Figure out a way to make a single API call and map the response data into multiple model attributes
  end
end
