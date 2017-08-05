class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def shopping_cart_total
    @shopping_cart_total = 0;

    if session[:cart_id]
      @shopping_cart_total = CartPost.where(cart_id: session[:cart_id]).count
    end
  end
  helper_method :shopping_cart_total

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

  private
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end
