class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def check_user_level(user_level)
    if current_user
      if current_user.level == user_level
        return true
      else
        return false
      end
    end
  end
  helper_method :check_user_level
end
