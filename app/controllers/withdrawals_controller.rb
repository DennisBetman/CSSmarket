class WithdrawalsController < ApplicationController
  before_action :authorize
  before_action only: [:update] do
    if !check_user_level(100)
      redirect_to root_path
    end
  end
  before_action only: [:create] do
    if check_user_level(0)
      redirect_to root_path
    end
  end

  def index
    @withdrawals = Withdrawal.order("created_at DESC").all
    render "admin/withdrawals/index"
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

    @withdrawal = Withdrawal.new withdrawal_params
    @withdrawal.user_id = current_user.id
    @withdrawal.amount = on_account

    if @withdrawal.save
      WithdrawalMailer.received(current_user, @withdrawal).deliver_later
      redirect_to dashboard_earnings_path
    else
      redirect_to dashboard_earnings_path
    end
  end

  def update
    @withdrawal = Withdrawal.find_by_id(params[:id])
    user = User.find_by_id(@withdrawal.user_id)

    if @withdrawal.update(withdrawal_params)
      WithdrawalMailer.accepted(user, @withdrawal).deliver_later
      redirect_to admin_withdrawals_path
    end
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:amount, :status)
  end
end
