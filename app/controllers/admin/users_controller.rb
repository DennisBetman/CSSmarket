class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order("created_at DESC").all
  end

  def show
    @user = User.find_by_id(params[:id])
  end
end
