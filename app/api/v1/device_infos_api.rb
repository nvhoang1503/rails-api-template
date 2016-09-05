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
          # requires :secure_auth_key, type: String, desc: "Security authentication key"
        end
        post "register" do 
          device_type = headers['Device-Type'] ||= params[:device_type]
          if DeviceInfoService.device_checking( device_type) 
            device_info = DeviceInfoService.anonymize(my_permitted_params, headers)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "Register new device is successful")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "The required keys have been missing")
          end 
        end
      end
    end
  end
end