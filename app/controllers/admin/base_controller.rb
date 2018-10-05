class Admin::BaseController < ApplicationController
  before_action :authorize
  before_action do
    if !check_user_level("admin")
      redirect_to root_path
    end
  end

  def index
  end
end
