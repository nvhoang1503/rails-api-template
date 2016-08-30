module DeviceInfoBase
  extend ActiveSupport::Concern

  included do
    # include Rails.application.routes.mounted_helpers
    # include Devise::Controllers::UrlHelpers
  end


  

  module ClassMethods

    def find_by_authentication_token(authentication_token)
      device_info = with_authentication_token(authentication_token)
    end

    def with_authentication_token(authentication_token)
      device_info = self.where(:authentication_token => authentication_token).try(:first)
      if device_info
        device_info.play_in_count = device_info.play_in_count + 1
        device_info.play_in_count = generate_authentication_token
        device_info.save
      end
      device_info
    end

    def anonymize(params)
      device_info =  DeviceInfo.anonymize(params)
    end

    def authorize(params)
      find_by_authentication_token(params[:authentication_token])
    end


    # Create new device info
    def anonymize
      device_info = self.new params
      device_info.authentication_token = generate_authentication_token
      device_info.save
      device_info
    end

    # Update device info for device tracking
    def update_device_info(device_info)
      if self.class.name == DeviceInfo.name
        raise Exceptions::CommonExceptions::Invalid.new(message: "The system das not permisson to get device info", is_system_error: true)
      end

      existed_device_info = DeviceInfo.find_by_device_id(device_info.device_info)

      if existed_device_info
        existed_device_info.user_id       = device_info.user_id       if device_info.user_id
        existed_device_info.device_type   = device_info.device_type   if device_info.device_type
        existed_device_info.device_name   = device_info.device_name   if device_info.device_name
        existed_device_info.device_token  = device_info.device_token  if device_info.device_token
        existed_device_info.os_version    = device_info.os_version    if device_info.os_version
        existed_device_info.screen_dpi    = device_info.screen_dpi    if device_info.screen_dpi
        existed_device_info.app_version   = device_info.app_version   if device_info.app_version
        existed_device_info.is_playing    = device_info.is_playing    if device_info.is_playing
        existed_device_info.app_name      = device_info.app_name      if device_info.app_name
        existed_device_info.country_code  = device_info.country_code  if device_info.country_code
        existed_device_info.locale        = device_info.locale        if device_info.locale

        existed_device_info.save
      else
        raise Exceptions::CommonExceptions::Invalid.new(message: "Can not update the device info", is_system_error: true)
      end
      existed_device_info
    end

    def update_play_in_count(device_info)
      device_info.update_attribute("play_in_count", device_info.play_in_count + 1)
    end

    
     
    def generate_authentication_token
      SecureRandom.hex(50)
    end

  end

end
