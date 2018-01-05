include Rails.application.routes.url_helpers

class PostsMailer < ApplicationMailer
  def approved(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "Your post has been approved!")
  end
end
