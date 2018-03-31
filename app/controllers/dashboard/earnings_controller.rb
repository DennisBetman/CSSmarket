class Dashboard::EarningsController < Dashboard::BaseController
  before_action do
    if check_user_level(0)
      redirect_to user_settings_path
    end
  end

  def index
    @current_withdrawal = Withdrawal.find_by_user_id_and_status(current_user.id, 0)
    @completed_withdrawals = Withdrawal.where(user_id: current_user.id).where(status: 1).all
    @all_withdrawals = Withdrawal.where(user_id: current_user.id).all

    @paid_out = 0

    posts = Post.where(user_id: current_user.id).all
    @succesful_orders = []
    @on_account = 0

    if @completed_withdrawals
      @completed_withdrawals.each do |withdrawal|
        @on_account = @on_account - withdrawal.amount

        @paid_out =+ withdrawal.amount
      end
    end

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where("created_at <= ?", 2.weeks.ago.utc).where(payment_type: "stripe").order("created_at DESC")
      @succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    @succesful_orders.each do |succesful_order|
      @on_account += succesful_order.amount
    end

    @succesful_orders = []
    @pending = 0

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where("created_at >= ?", 2.weeks.ago.utc).where(payment_type: "stripe").order("created_at ASC")
      @succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    @succesful_orders.each do |succesful_order|
      @pending += succesful_order.amount
    end

    @succesful_orders = []

    posts.each do |post|
      tsuccesful_orders = Order.where(post_id: post.id).where(payment_type: "stripe").order("created_at DESC")
      @succesful_orders += tsuccesful_orders if tsuccesful_orders
    end

    @succesful_orders = @succesful_orders.sort_by{ |i| i.created_at }.reverse!

    @nano_orders = []

    posts.each do |post|
      tnano_orders = Order.where(post_id: post.id).where(payment_type: "nano").order("created_at DESC")
      @nano_orders += tnano_orders if tnano_orders
    end

    @nano_orders = @nano_orders.sort_by{ |i| i.created_at }.reverse!
  end
end
