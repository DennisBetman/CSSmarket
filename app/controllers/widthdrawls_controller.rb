class WidthdrawlsController < ApplicationController
  before_action :authorize
  before_action do
    if !check_user_level(100)
      redirect_to root_path
    end
  end

  def index
  end

  def create
    posts = Post.where(user_id: current_user.id).all
    succesful_orders = []
    on_account = 0

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where("created_at <= ?", 2.weeks.ago.utc).order("created_at DESC")
      succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    succesful_orders.each do |succesful_order|
      on_account += succesful_order.amount
    end

    @widthdrawl = Widthdrawl.new widthdrawl_params
    @widthdrawl.user_id = current_user.id
    @widthdrawl.amount = on_account

    if @widthdrawl.save
      redirect_to dashboard_earnings_path
    else
      redirect_to dashboard_earnings_path
    end
  end

  def update
    Widthdrawl.update(widthdrawl_params)
    redirect_to admin_widthdrawls_path
  end

  private
  
  def widthdrawl_params
    params.require(:widthdrawl).permit(:amount, :status)
  end
end
