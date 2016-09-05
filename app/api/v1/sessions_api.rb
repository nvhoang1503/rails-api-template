module API
  module V1
    class SessionsApi < API::V1::BaseApi

      resource :sessions do
        helpers do
          def my_permitted_keys
            [:app_key]
          end
        end

        # Create new device session api
        desc 'Create new session'
        params do 
          # requires :secure_auth_key, type: String, desc: "Security authentication key"
          optional :device_type, type: String, desc: "Device Type"
          optional :device_id, type: String, desc: "Device Id"
        end
        post "create" do 
          device_type = headers['Device-Type']  ||= params[:device_type]
          device_id   = headers['Device-Id']    ||= params[:device_id]
          if DeviceInfoService.device_checking(device_type)
            device_info = DeviceInfoService.play_in(device_id, headers)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "The device is playing")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "Permission deny")
          end 
        end

        # Reset new authentication token api
        desc 'Delete session'
        params do 
          requires :authentication_token, type: String, desc: "Authentication Token"
        end
        delete "reset" do 
          device_info_authenticate!
          current_device_info.play_off
          API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 200, message: "The device has been off")
        end
      end
    end
  end
end