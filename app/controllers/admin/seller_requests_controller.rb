class Admin::SellerRequestsController < Admin::BaseController
  def index
    @seller_requests = SellerRequest.order("created_at DESC").all
  end
end
