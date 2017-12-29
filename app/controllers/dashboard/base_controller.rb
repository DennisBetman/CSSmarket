class Dashboard::BaseController < ApplicationController
  before_action :authorize

  def index
  end
end
