class Admin::WidthdrawlsController < Admin::BaseController
  def index
    @widthdrawls = Widthdrawl.order("created_at DESC").all
  end
end
