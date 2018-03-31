class NanoPaymentsController < ApplicationController
  def create
    @post = Post.find_by_id params[:post_id]

    @order = Order.new(amount: @post.price, description: @post.title, customer_id: params[:token], source: "nano", post_id: @post.id, user_id: current_user.id, payment_type: "nano")

    if @order.save
      render file: "charges/success.js.erb"

      PurchaseMailer.confirm(current_user, @post).deliver_later

      seller_id = Post.find_by_id(@post.user_id)
      seller = User.find_by_id(seller_id)
      PurchaseMailer.notify_seller(seller, @post).deliver_later
    else
      render file: "charges/error.js.erb"
    end
  end
end
