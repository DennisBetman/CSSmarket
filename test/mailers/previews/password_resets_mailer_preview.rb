class PasswordResetsMailerPreview < ActionMailer::Preview
  def password_reset
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    token = "DXrb9U7hcwNsVfRNzU8k"
    PasswordResetsMailer.password_reset(user, token)
  end
end
