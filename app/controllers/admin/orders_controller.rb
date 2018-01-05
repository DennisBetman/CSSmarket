class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.order("created_at DESC").all
  end
end
