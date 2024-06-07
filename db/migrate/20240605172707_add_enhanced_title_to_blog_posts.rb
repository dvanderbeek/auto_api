class AddEnhancedTitleToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :enhanced_title, :virtual, type: :string, as: "title || ' asdf'", stored: true
  end
end
