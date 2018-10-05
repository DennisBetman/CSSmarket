class PostsMailerPreview < ActionMailer::Preview
  def approved
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    post = Post.first
    PostsMailer.approved(user, post)
  end
end
