module Blog
  class Post < ApplicationRecord
    # default_scope -> { Current.user == 'david' ? all : none }
    restrict :enhanced_title
  end
end
