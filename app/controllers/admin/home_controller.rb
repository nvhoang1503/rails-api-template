class Admin::HomeController < Admin::BaseController
  before_action :authenticate_user!
  def index
  end
end
