require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "can create new user" do
    assert_difference "User.count" do
      post users_path(params: {
        user: {
          email: "newuser@example.com",
          password: "password",
          password_confirmation: "password",
          username: "John"
        }
      })
    end
  end
end
