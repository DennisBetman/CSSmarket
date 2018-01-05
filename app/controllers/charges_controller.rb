class ChargesController < ApplicationController
  before_action :set_cart, only: [:create, :destroy]
  before_action :authorize

  def new
    cart

    if @posts == []
      redirect_to cart_path
    end
  end

  def create
    cart

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
        session.delete(:cart_id)
        PurchaseMailer.confirm(current_user, post).deliver_later

        seller_id = Post.find_by_id(post.user_id)
        seller = User.find_by_id(seller_id)
        PurchaseMailer.notify_seller(seller, post).deliver_later
      else
        redirect_to cart_path, flash: { error: "Something went horribly wrong" }
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
  
  def cart
    @cart = session[:cart_id]
    @cart_posts = CartPost.where(cart_id: @cart).all
    @posts = []
    @total_price = 0
    @order_description = ""

    @cart_posts.each do |post|
      tposts = Post.where(id: post.post_id).order("created_at DESC")
      @posts += tposts if tposts
    end

    @posts.each do |post|
      @total_price += post.price.to_i
      @order_description += post.title + ", "
    end
  end
end
