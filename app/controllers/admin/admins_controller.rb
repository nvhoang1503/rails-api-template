class Admin::AdminsController < ApplicationController
  def index
    @admins = Admin.page(params[:page]).per(5)

    respond_to do |format|
      format.json  {
        render :json => {
          data: @admins,
          pageInfo: {
            totalPages: @admins.total_pages,
            currentPage: params[:page] || 1,
            windowSize: 3
          }
        }
      }
    end
  end
end
