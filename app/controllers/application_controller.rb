class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def apidoc
    redirect_to "#{request.protocol + request.host_with_port}/api/swagger"
  end
  
end
