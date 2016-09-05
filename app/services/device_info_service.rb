class DeviceInfoService < BaseService

  def self.anonymize(params, headers)
    DeviceInfo.anonymize(params, headers)
  end

  def self.play_in(device_id, headers)
    DeviceInfo.play_in(device_id, headers)
  end

  def self.device_checking(device_type)
    flag = false
    puts "==== device_checking  DEV_SECURE_AUTH_KEY: ",ENV["DEV_SECURE_AUTH_KEY"]
    if device_type.present?
      flag = true
      # if device_type.downcase == 'android' 
      #   flag = true
      # elsif device_type.downcase == 'ios' 
      #   flag = true
      # elsif device_type.downcase == 'dev'
      #   flag = true
      # end
    end
    flag  
  end

  # def self.device_checking(secure_auth_key, device_type)
  #   flag = false
  #   puts "==== device_checking  DEV_SECURE_AUTH_KEY: ",ENV["DEV_SECURE_AUTH_KEY"]
  #   if device_type.present?
  #     if device_type.downcase == 'android' && secure_auth_key == ENV["ANDROID_SECURE_AUTH_KEY"]
  #       flag = true
  #     elsif device_type.downcase == 'ios' && secure_auth_key == ENV["IOS_SECURE_AUTH_KEY"]
  #       flag = true
  #     elsif device_type.downcase == 'dev' && secure_auth_key == ENV["DEV_SECURE_AUTH_KEY"]
  #       flag = true
  #     end
  #   end
  #   flag  
  # end

  def self.generate_authentication_token
    SecureRandom.hex(30)
  end

end