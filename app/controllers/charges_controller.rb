class ChargesController < ApplicationController
  before_action :authorize

  def new
  end

  def create
    @post = Post.find_by_id params[:charge][:post_id]
    @author = User.find_by_id @post.user_id

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
      :amount      => @post.price.to_i * 100,
      :description => @post.title,
      :currency    => source.currency
    )

    @order = Order.new(amount: @post.price, author_cut: @post.price.to_d * @author.cut_percentage, description: @post.title, customer_id: customer.id, source: charge.id, post_id: @post.id, user_id: current_user.id, payment_type: "stripe")

    if @order.save
      render file: "charges/success.js.erb"

      PurchaseMailer.confirm(current_user, @post).deliver_later

      seller_id = Post.find_by_id(@post.user_id)
      seller = User.find_by_id(seller_id)
      PurchaseMailer.notify_seller(seller, @post).deliver_later
    else
      render file: "charges/error.js.erb"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
end
