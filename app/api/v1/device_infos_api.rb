module API
  module V1
    class DeviceInfosApi < API::V1::BaseApi

      resource :device_infos do
        helpers do
          def my_permitted_keys
            [:app_key]
          end
        end

        # Register device
        desc 'Register new device'
        params do 
          requires :secure_auth_key, type: String, desc: "Security authentication key"
        end
        post "register" do 
          device_type = headers['Device-Type'] ||= params[:device_type]
          if DeviceInfoService.device_checking(params[:secure_auth_key], device_type) 
            device_info = DeviceInfoService.anonymize(my_permitted_params, headers)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "Register new device is successful")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "The required keys have been missing")
          end 
        end

        # play in api
        desc 'Play in'
        params do 
          requires :secure_auth_key, type: String, desc: "Security authentication key"
          optional :device_type, type: String, desc: "Device Type"
          optional :device_id, type: String, desc: "Device Id"
        end
        post "play_in" do 
          device_type = headers['Device-Type']  ||= params[:device_type]
          device_id   = headers['Device-Id']    ||= params[:device_id]
          if DeviceInfoService.device_checking(params[:secure_auth_key], device_type)
            device_info = DeviceInfoService.play_in(device_id)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "The device is playing")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "Permission deny")
          end 
        end

        # play off api
        # play in api
        desc 'Play in'
        params do 
          requires :authentication_token, type: String, desc: "Authentication Token"
        end
        delete "play_off" do 
          device_info_authenticate!
          current_device_info.play_off
          API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 200, message: "The device has been off")
        end
      end
    end
  end
end