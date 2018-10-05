require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "can get login page" do
    get login_path
    assert_response :success
  end
end
