module DeviceInfoBase
  extend ActiveSupport::Concern

  included do
    # include Rails.application.routes.mounted_helpers
    # include Devise::Controllers::UrlHelpers
  end

  def reset_session
    authentication_token = DeviceInfoService.generate_authentication_token
    self.update_attributes( 
                          :authentication_token => authentication_token,
                          :is_playing => false,
                          :last_play_off_at => DateTime.now
                        )
  end

  module ClassMethods

    def create_new_session(headers)
      device_id = headers['Device-Id']
      device_info = self.where(:device_id => device_id).try(:first)
      if device_info
        play_in_count = device_info.play_in_count + 1
        authentication_token = DeviceInfoService.generate_authentication_token

        data_changed = {
                    :play_in_count => play_in_count, 
                    :authentication_token => authentication_token,
                    :is_playing => true,
                    :last_play_in_at => DateTime.now
                  }
        device_info = update_device_info(device_info, data_changed, headers)
        return device_info
      end
      nil
    end

    def find_by_authentication_token(authentication_token)
      device_info = with_authentication_token(authentication_token)
    end

    def with_authentication_token(authentication_token)
      device_info = self.where(:authentication_token => authentication_token).try(:first)
    end


    def authorize(params)
      device_info = find_by_authentication_token(params[:authentication_token]) if params[:authentication_token]
      return device_info
    end


    # # Create new device info
    def anonymize(params, headers)
      device_info = self.find_by_device_id(headers['Device-Id'])
      if device_info
        device_info = update_device_info(device_info, params, headers)
      else
        device_info = create_device_info(params, headers)
      end
      device_info  
    end

    def create_device_info(params, headers)
      device_info = self.new(
                              device_type: headers['Device-Type'],
                              device_name: headers['Device-Name'],
                              device_id: headers['Device-Id'],
                              device_token: headers['Device-Token'],
                              os_version: headers['Os-Version'],
                              screen_dpi: headers['Screen-Dpi'],
                              app_version: headers['App-Version'],
                              app_name: headers['App-Name'],
                              locale: headers['Accept-Language'],
                              country_code: params[:country_code]
                            )
      device_info.is_playing = true
      device_info.play_in_count = 1
      device_info.last_play_in_at = DateTime.now
      device_info.authentication_token = DeviceInfoService.generate_authentication_token
      device_info.save
      device_info
    end

    # def update_device_info(device_info)
    def update_device_info(device_info, params, headers = {})
      info_update = {}
      info_update = info_update.merge(:user_id      => params[:user_id])            if device_info.user_id      != params[:user_id]
      info_update = info_update.merge(:device_type  => headers['Device-Type'])      if device_info.device_type  != headers['Device-Type']
      info_update = info_update.merge(:device_name  => headers['Device-Name'])      if device_info.device_name  != headers['Device-Name']
      info_update = info_update.merge(:device_id    => headers['Device-Id'])        if device_info.device_id    != headers['Device-Id']
      info_update = info_update.merge(:os_version   => headers['Os-Version'])       if device_info.os_version   != headers['Os-Version']
      info_update = info_update.merge(:screen_dpi   => headers['Screen-Dpi'])       if device_info.screen_dpi   != headers['Screen-Dpi']
      info_update = info_update.merge(:app_version  => headers['App-Version'])      if device_info.app_version  != headers['App-Version']
      info_update = info_update.merge(:app_name     => headers['App-Name'])         if device_info.app_name     != headers['App-Name']
      info_update = info_update.merge(:locale       => headers['Accept-Language'])  if device_info.locale       != headers['Accept-Language']
      
      if params
        info_update = info_update.merge(params)
      end
      if info_update.size > 0
        device_info.authentication_token = DeviceInfoService.generate_authentication_token
        device_info.update_attributes(info_update)
      end
      device_info
    end

  end

end
