class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.order("created_at DESC").all

    @posts.each do |post|
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end
  end

  def show
    @posts = Post.where(parent_id: params[:id]).order("created_at DESC").all

    @posts.each do |post|
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end
  end
end
