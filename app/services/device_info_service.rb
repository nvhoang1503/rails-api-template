class DeviceInfoService < BaseService

  # def initialize(device_info, params = {})
  #   @device_info = device_info
  #   @params = params
  # end

  def self.anonymize(params, headers)
    DeviceInfo.anonymize(params, headers)
  end

  # def anonymize
  #   device_info = DeviceInfo.new params
  #   device_info.authentication_token = generate_authentication_token
  #   device_info.save
  #   device_info
  # end


  # def generate_authentication_token
  #   SecureRandom.hex(50)
  # end



end