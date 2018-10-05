include Rails.application.routes.url_helpers

class PasswordResetsMailer < ApplicationMailer
  def password_reset(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Password Reset")
  end
end
