module Blog
  class Post
    class Attrs
      def self.valid
        {
          id: 1,
          created_at: Time.current,
          updated_at: Time.current,
          title: 'My first post',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
        }
      end
    end
  end
end
