class Dashboard::BaseController < ApplicationController
  before_action :authorize
  before_action only: [:earnings, :projects] do
    if check_user_level(0)
      redirect_to user_settings_path
    end
  end

  def index
  end
end
