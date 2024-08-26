module Accounts
  class User < ApplicationRecord
    attribute :validated, :boolean, default: true
    validates :name, name: true

    # autopopulates :name, with: :fetch_name
    # OR a proc / lambda / other callable object
    autopopulates :name, with: ->(user) { NameApiClient.new.get_name(user) }
    # autopopulates :name, with: NameApiClient.new.method(:get_name)

    # def fetch_name
    #   NameApiClient.new.get_name(self)
    # end
  end
end
