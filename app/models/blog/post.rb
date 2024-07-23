module Blog
  class Post < ApplicationRecord
    include Wisper::Publisher
    # default_scope -> { Current.user == 'david' ? all : none }

    after_create do
      broadcast(:blog_post_published, id)
    end

    declarative_enum Blog::StatusEnum

    def self.unpermitted_attributes
      %w[id created_at updated_at enhanced_title]
    end
  end
end
