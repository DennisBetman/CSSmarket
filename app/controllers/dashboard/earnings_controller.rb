class Dashboard::EarningsController < Dashboard::BaseController
  before_action do
    if check_user_level(0)
      redirect_to user_settings_path
    end
  end
  
  def index
    @current_widthdrawl = Widthdrawl.find_by_user_id_and_status(current_user.id, 0)
    @all_widthdrawls = Widthdrawl.where(user_id: current_user.id).all

    @paid_out = 0

    posts = Post.where(user_id: current_user.id).all
    @succesful_orders = []
    @on_account = 0

    if @all_widthdrawls
      @all_widthdrawls.each do |widthdrawl|
        @on_account = @on_account - widthdrawl.amount

        @paid_out =+ widthdrawl.amount
      end
    end

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where("created_at <= ?", 2.weeks.ago.utc).order("created_at DESC")
      @succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    @succesful_orders.each do |succesful_order|
      @on_account += succesful_order.amount
    end


    @succesful_orders = []
    @pending = 0

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where("created_at >= ?", 2.weeks.ago.utc).order("created_at DESC")
      @succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    @succesful_orders.each do |succesful_order|
      @pending += succesful_order.amount
    end
  end
end
