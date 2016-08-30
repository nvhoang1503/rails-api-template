module API
  module Entities
    module V1
      class DeviceInfoEntity < API::Entities::V1::BaseEntity
        root 'data', 'object'

        ENTITY_TYPE = :device_info

        expose :id
        expose :device_id, if: include_params(:basic, :device_id)
        expose :device_token, if: include_params(:basic, :device_token)
        expose :device_type, if: include_params(:basic, :device_type)
        expose :device_name, if: include_params(:basic, :device_name)
        expose :authentication_token, if: include_params(:basic, :authentication_token)

        expose :app_version, if: include_params(:details)
        expose :os_version, if: include_params(:details)
        expose :screen_dpi, if: include_params(:details)
        expose :app_name, if: include_params(:details)
        expose :locale, if: include_params(:details)
        expose :is_playing, if: include_params(:details)
        expose :country_code, if: include_params(:details)


      end
    end
  end
end
