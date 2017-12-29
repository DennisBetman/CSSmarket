class Dashboard::ProjectsController < Dashboard::BaseController
  def index
    @posts = Post.group(:parent_id).where(status: 1).order("created_at DESC").all.to_a
  end
end
