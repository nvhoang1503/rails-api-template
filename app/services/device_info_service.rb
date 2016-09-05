class DeviceInfoService < BaseService

  def self.anonymize(params, headers)
    DeviceInfo.anonymize(params, headers)
  end

  def self.create_new_session( headers)
    DeviceInfo.create_new_session(headers)
  end

  def self.device_checking(headers)
    flag = true
    errors = []
    if headers['Device-Type'].present? == false
      flag = false
      errors << "Missing Device Type"
    end
    if headers['Device-Id'].present? == false
      flag = false
      errors << "Missing Device ID"
    end
    if headers['Device-Name'].present? == false
      flag = false
      errors << "Missing Device Name"
    end
    if headers['Device-Token'].present? == false
      flag = false 
      errors << "Missing Device Token"
    end  
    result = {
                status: flag,
                errors: errors
              }
  end

  def self.generate_authentication_token
    SecureRandom.hex(30)
  end

end