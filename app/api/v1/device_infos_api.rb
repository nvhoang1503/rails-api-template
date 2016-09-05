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
          optional :device_type, type: String, desc: "Device Type"
          optional :device_id, type: String, desc: "Device Id"
          optional :device_name, type: String, desc: "Device Name"
          optional :device_token, type: String, desc: "Device Token"
        end
        post "register" do 
          headers['Device-Type']  = headers['Device-Type']  ||= params[:device_type]
          headers['Device-Id']    = headers['Device-Id']    ||= params[:device_id]
          headers['Device-Name']  = headers['Device-Name']  ||= params[:device_name]
          headers['Device-Token'] = headers['Device-Token'] ||= params[:device_token]
          checking = DeviceInfoService.device_checking(headers)
          if checking[:status] == true 
            device_info = DeviceInfoService.anonymize(my_permitted_params, headers)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "Register new device is successful")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "The required keys have been missing", errors: checking[:errors])
          end 
        end
      end
    end
  end
end