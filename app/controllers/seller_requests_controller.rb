class SellerRequestsController < ApplicationController
  before_action :authorize

  def new
    @seller_request = SellerRequest.new
  end

  def create
    @seller_request = SellerRequest.new seller_request_params
    @seller_request.user_id = current_user.id

    if @seller_request.save
      redirect_to root_path, flash: { global_message: "Submition received, thanks!" }
    else
      render "new"
    end
  end

  private

  def seller_request_params
    params.require(:seller_request).permit :content, :portfolio_url
  end
end
