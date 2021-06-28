class Post
  attr_reader :title, :content, :slug, :blog

  def initialize(title:, content:, blog:)
    @title = title
    @content = content
    @blog = blog
    @slug = title.downcase.gsub(" ", "-")
  end

  def subdomain
    @blog.subdomain
  end
end
