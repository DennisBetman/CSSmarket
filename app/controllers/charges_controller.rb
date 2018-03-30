class ChargesController < ApplicationController
  before_action :authorize

  def new
  end

  def create
    card = params[:charge]

    source = Stripe::Source.create(
      :type => "card",
      :card => {
        :number => params[:charge][:card_number],
        :exp_month => params[:charge][:card_exp_month],
        :exp_year => params[:charge][:card_exp_year],
        :cvc => params[:charge][:card_cvc]
      },
      :currency => "eur"
    )

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source  => source
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @total_price * 100,
      :description => @order_description,
      :currency    => source.currency
    )

    @posts.each do |post|
      @order = Order.new(amount: post.price, description: post.title, customer_id: customer.id, source: charge.id, post_id: post.id, user_id: current_user.id)

      if @order.save
        PurchaseMailer.confirm(current_user, post).deliver_later

        seller_id = Post.find_by_id(post.user_id)
        seller = User.find_by_id(seller_id)
        PurchaseMailer.notify_seller(seller, post).deliver_later
      else
        redirect_to root_path, flash: { error: "Something went horribly wrong" }
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
end
