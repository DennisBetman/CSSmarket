include Rails.application.routes.url_helpers

class PostsMailer < ApplicationMailer
  def approved(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "Your post has been approved!")
  end

  def declined(user, post, description)
    @user = user
    @post = post
    @description = description
    mail(to: @user.email, subject: "Your post has been declined.")
  end
end
