require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "can get root page" do
    get root_path
    assert_response :success
  end
end
