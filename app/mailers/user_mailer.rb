include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to our site!")
  end

  def account_updated(user)
    @user = user
    mail(to: @user.email, subject: "Your account has been updated")
  end
end
