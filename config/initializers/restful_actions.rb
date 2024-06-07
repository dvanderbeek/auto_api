module RestfulActions
  extend ActiveSupport::Concern

  included do
    class_attribute :available_restful_actions
  end

  class_methods do
    def restful_actions(*actions)
      self.available_restful_actions = actions
    end
  end
end

ActiveRecord::Base.include(RestfulActions)
