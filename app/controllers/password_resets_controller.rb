class PasswordResetsController < ApplicationController
  def show
    unless current_user
      @password_reset = PasswordReset.where("created_at >= ?", 30.minutes.ago).find_by_reset_id(params[:reset_id])

      unless @password_reset
        redirect_to root_path, flash: { global_message: "The reset token was not found or has expired." }
      else
        @user = User.find_by_id(@password_reset.user_id)
      end
    else
      redirect_to root_path
    end
  end

  def new
    unless current_user
      @password_reset = PasswordReset.new
    else
      redirect_to root_path
    end
  end

  def create
    @password_reset = PasswordReset.new password_reset_params

    reset_token = SecureRandom.hex(16)
    @password_reset.reset_id = reset_token

    user = User.find_by_email(@password_reset.email)
    if user
      @password_reset.user_id = user.id

      if @password_reset.save
        PasswordResetsMailer.password_reset(user, reset_token).deliver_later
        redirect_to new_password_reset_path, flash: { password_sent: "An email has been sent. Follow the instructions to reset your password." }
      else
        render "new"
      end
    else
      redirect_to new_password_reset_path, flash: { password_sent: "An email has been sent. Follow the instructions to reset your password." }
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit :email
  end
end
