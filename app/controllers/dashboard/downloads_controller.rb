class Dashboard::DownloadsController < Dashboard::BaseController
  def index
    @succesful_orders = Order.where(user_id: current_user.id).all
    @posts = []

    @succesful_orders.each do |succesful_order|
      tposts = Post.where(id: succesful_order.post_id).group(:parent_id).where(status: 1).order("created_at DESC").all.to_a
      @posts += tposts if tposts
    end

    @posts.each do |post|
      user = User.select("id", "name").find_by_id(post.user_id)
      post.user_name = user.name
    end

    @total_posts = @posts ? @posts.count : 0
  end
end
