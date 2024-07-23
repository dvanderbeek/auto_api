Rails.application.reloader.to_prepare do
  Wisper.clear if Rails.env.development?

  Blog::Post.subscribe(Blog::PostNotifier.new)
end
