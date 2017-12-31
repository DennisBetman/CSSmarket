class Dashboard::ProjectsController < Dashboard::BaseController
  before_action do
    if check_user_level(0)
      redirect_to user_settings_path
    end
  end

  def index
    @posts = Post.group(:parent_id).where(status: 1).where(user_id: current_user.id).order("created_at DESC").all.to_a
  end
end
