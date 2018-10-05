class PurchaseMailerPreview < ActionMailer::Preview
  def confirm
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    purchase = Post.first
    PurchaseMailer.confirm(user, purchase)
  end

  def notify_seller
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    purchase = Post.first
    PurchaseMailer.notify_seller(user, purchase)
  end
end
