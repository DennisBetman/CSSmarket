require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "can create new user" do
    assert_difference "User.count" do
      post users_path(params: {
        user: {
          name: "john",
          email: "newuser@example.com",
          password: "password",
          password_confirmation: "password"
        }
      })
    end
  end
end
