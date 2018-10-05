class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome(@user).deliver_later
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "sessions/new"
    end
  end

  def show
    @user = User.select("id", "name", "created_at").find_by_name(params[:name])
    @posts = Post.group(:parent_id).where(user_id: @user.id).where(status: 1).order("created_at DESC").all.to_a
  end

  def update
    user = User.find_by_id(params[:id])

    if user.update(user_params)
      if user_params[:password]
        UserMailer.account_updated(user).deliver_later
        redirect_to request.referrer, flash: { global_message: "Your account has been updated" }
      end
    else
      redirect_to request.referrer, flash: { user_error: "A field was invalid" }
    end
  end

  def settings

  end

  def destroy
    @user = User.find_by_id current_user.id

    @user.update(name: SecureRandom.urlsafe_base64(4), email: "#{SecureRandom.urlsafe_base64(4)}@deleted.com", password: SecureRandom.urlsafe_base64(16), level: 0, nano_address: "", paypal_address: "", status: 1)

    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :level, :cut_percentage, :nano_address, :paypal_address)
  end
end
