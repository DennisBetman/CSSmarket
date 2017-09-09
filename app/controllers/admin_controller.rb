class AdminController < ApplicationController
  before_action :authorize
  before_action do
    if !check_user_level(100)
      redirect_to root_path
    end
  end

  def index
  end

  def users
    @users = User.order("created_at DESC").all
  end

  def orders
    @orders = Order.order("created_at DESC").all
  end

  def posts
    @posts = Post.order("created_at DESC").all

    user_id_to_name
  end

  def widthdrawls
    @widthdrawls = Widthdrawl.order("created_at DESC").all
  end

  private

  def user_id_to_name()
    @posts.each do |post|
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end
  end
end
