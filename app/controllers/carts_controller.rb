class CartsController < ApplicationController
  def index
    cart
  end

  private
  
  def cart
    @cart = session[:cart_id]
    @cart_posts = CartPost.where(cart_id: @cart).all
    @posts = []
    @total_price = 0

    @cart_posts.each do |post|
      tposts = Post.where(id: post.post_id).order("created_at DESC")
      @posts += tposts if tposts
    end

    @posts.each do |post|
      @total_price += post.price.to_i
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end
  end
end
