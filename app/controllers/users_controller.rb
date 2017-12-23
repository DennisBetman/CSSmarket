class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.welcome(user).deliver_later
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path, flash: { user_error: "A field was invalid" }
    end
  end

  def show
    @user = User.select("id", "name", "created_at").find_by_name(params[:name])
    @posts = Post.group(:parent_id).where(user_id: @user.id).where(status: 1).order("created_at DESC").all.to_a
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
