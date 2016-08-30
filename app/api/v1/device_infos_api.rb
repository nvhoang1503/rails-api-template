module API
  module V1
    class DeviceInfosApi < API::V1::BaseApi

      resource :device_infos do
        helpers do
          def my_permitted_keys
            [ :api_key, :app_key]
          end
        end

        # Register device
        desc 'Register new device'
        params do 
          requires :api_key, type: String, desc: "API key"
        end
        post "register" do 
          device_info = DeviceInfoService.anonymize(my_permitted_params, headers)
          API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "Register new device is successful !")
        end

        # play in api

        # play off api
      end
    end
  end
end