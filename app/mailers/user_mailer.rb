include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to our site!")
  end

  def password_updated(user)
    @user = user
    mail(to: @user.email, subject: "Your password has been updated")
  end
end
