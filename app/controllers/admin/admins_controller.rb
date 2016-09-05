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
      if @admin.errors.messages.values
        messages = @admin.errors.full_messages.map do |message|
          {
            content: message,
            type: "error"
          }
        end
      end

      respond_to do |format|
        format.json  {
          render :json => {
            messages: messages
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
