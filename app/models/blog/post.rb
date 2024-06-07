module Blog
  class Post < ApplicationRecord
    # default_scope -> { Current.user == 'david' ? all : none }
  end
end
