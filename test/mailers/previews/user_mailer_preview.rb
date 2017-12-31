class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    UserMailer.welcome(user)
  end

  def account_updated
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    UserMailer.account_updated(user)
  end
end
