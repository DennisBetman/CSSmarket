include Rails.application.routes.url_helpers

class PurchaseMailer < ApplicationMailer
  def confirm(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: @user.email, subject: "Thank you for your purchase!")
  end

  def notify_seller(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: @user.email, subject: "Someone has bought your thing!")
  end
end
