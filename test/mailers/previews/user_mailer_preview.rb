class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    UserMailer.welcome(user)
  end
end
