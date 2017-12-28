require 'test_helper'

class SellerRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get seller_requests_create_url
    assert_response :success
  end

end
