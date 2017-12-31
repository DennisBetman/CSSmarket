class WithdrawalMailerPreview < ActionMailer::Preview
  def accepted
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    withdrawal = OpenStruct.new(amount: "20")
    WithdrawalMailer.accepted(user, withdrawal)
  end

  def received
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    withdrawal = OpenStruct.new(amount: "20")
    WithdrawalMailer.received(user, withdrawal)
  end
end
