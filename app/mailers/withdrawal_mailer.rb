include Rails.application.routes.url_helpers

class WithdrawalMailer < ApplicationMailer
  def received(user, withdrawal)
    @user = user
    @withdrawal = withdrawal
    mail(to: @user.email, subject: "Your withdrawal request has been received")
  end

  def accepted(user, withdrawal)
    @user = user
    @withdrawal = withdrawal
    mail(to: @user.email, subject: "Your withdrawal request has been accepted")
  end
end
