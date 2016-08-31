class HomeController < ApplicationController
  def index
  end

  def dashboard
    respond_to do |format|
      format.js do
      end
    end
  end

  def admins
    respond_to do |format|
      format.js do
      end
    end
  end
end
