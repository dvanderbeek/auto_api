module Blog
  class Post < ApplicationRecord
    # default_scope -> { Current.user == 'david' ? all : none }

    def self.unpermitted_attributes
      %w[id created_at updated_at enhanced_title]
    end
  end
end
