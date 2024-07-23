module Blog
  class PostNotifier
    def blog_post_published(post_id)
      puts "SENDING NOTIFICATION ABOUT POST #{post_id}"
    end
  end
end
