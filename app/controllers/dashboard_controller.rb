class DashboardController < ApplicationController
  before_action :authorize
  before_action only: [:earnings, :projects] do
    if check_user_level(0)
      redirect_to dashboard_path
    end
  end

  def index
  end

  def downloads
    @succesful_orders = Order.where(user_id: current_user.id).all
    @posts = []

    @succesful_orders.each do |succesful_order|
      tposts = Post.where(id: succesful_order.post_id).order("created_at DESC")
      @posts += tposts if tposts
    end

    @posts.each do |post|
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end

    @total_posts = @posts ? @posts.count : 0
  end

  def earnings
    posts = Post.where(user_id: current_user.id).all
    @succesful_orders = []
    @on_account = 0

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
    

    @paid_out = 0
  end

  def projects
    @posts = Post.where(user_id: current_user.id).all
  end
end
