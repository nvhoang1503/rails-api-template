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

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      respond_to do |format|
        format.json  {
          render :json => {
            messages: [
              {
                content: "Created admin successfully",
                type: "success"
              }
            ]
          }
        }
      end
    else
      error_message = @admin.errors.full_messages.join(". ") if @admin.errors.messages.values
      respond_to do |format|
        format.json  {
          render :json => {
            messages: [
              {
                content: error_message,
                type: "error"
              }
            ]
          }
        }
      end
    end
  end

  private 

  def admin_params
    params_admin = params.require(:admin)
    params_admin.permit(:email, :password, :password_confirmation)
  end

end
