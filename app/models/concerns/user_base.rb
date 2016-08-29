module UserBase
  extend ActiveSupport::Concern

  included do
    # include Rails.application.routes.mounted_helpers
    # include Devise::Controllers::UrlHelpers
  end


  def check_invalid_phone
    if phone && country_code && !GlobalPhone.validate(phone, country_code)
      errors.add(:base, I18n.t("errors.messages.invalid_phone"))
    end
  end

  def check_invalid_phone
    if phone && country_code && !GlobalPhone.validate(phone, country_code)
      errors.add(:base, I18n.t("errors.messages.invalid_phone"))
    end
  end

  def sign_out_api(device_id)
    # if self.class.name == User.name
    #   raise Exceptions::CommonExceptions::Invalid.new(message: "Input user hasn't been specified a role", is_system_error: true)
    # end
    # self.users_role.try(:sign_out_api, device_id)
  end


  def authentication_token(device_id)
    if self.class.name == User.name
      raise Exceptions::CommonExceptions::Invalid.new(message: "Input user hasn't been specified a role", is_system_error: true)
    end
    self.users_role.try(:authentication_token, device_id)
  end

  # def change_password(old_password, new_password)
  #   if self.valid_password?(old_password)
  #     self.password = new_password
  #     if self.save
  #       result = {status: true, object: self}
  #     else
  #       error_message = self.errors.messages.values.join(". ") if self.errors.messages.values
  #       result = {status: false, errors: error_message}
  #     end
  #   else
  #       result = {status: false, errors: I18n.t('labels.current_password_uncorrect')}
  #   end
  #   result
  # end

  def generate_authentication_token(device_id)
    # if self.class.name == User.name
    #   raise Exceptions::CommonExceptions::Invalid.new(message: "Input user hasn't been specified a role", is_system_error: true)
    # end
    # self.users_role.generate_authentication_token(device_id)
  end

  def set_new_authentication_token(device_id)
    # if self.class.name == User.name
    #   raise Exceptions::CommonExceptions::Invalid.new(message: "Input user hasn't been specified a role", is_system_error: true)
    # end
    # self.users_role.set_new_authentication_token(device_id)
  end

  def format_phone
    self.phone = self.class.normalize_phone phone, country_code
  end

  # def users_role
  #   role = Role.find_by_name(self.class.name.downcase)
  #   self.users_roles.select{|ur| ur.role_id == role.try(:id)}.first
  # end

  # Update device info for user (device tracking)
  # @param DeviceInfo device_info
  def update_device_info(device_info)
    # if self.class.name == User.name
    #   raise Exceptions::CommonExceptions::Invalid.new(message: "Input user hasn't been specified a role", is_system_error: true)
    # end

    # if device_info && device_info.try(:device_id)
    #   device_info.is_online = true
    #   existed_device_info = self.users_roles.of_role_name(self.class.name).first
    #                                         .device_infos
    #                                         .of_device_id(device_info.device_id)
    #                                         .first
    #   if existed_device_info
    #     existed_device_info.device_type = device_info.device_type
    #     existed_device_info.device_name = device_info.device_name
    #     existed_device_info.device_token = device_info.device_token
    #     existed_device_info.os_version = device_info.os_version
    #     existed_device_info.screen_dpi = device_info.screen_dpi
    #     existed_device_info.app_version = device_info.app_version
    #     existed_device_info.is_online = device_info.is_online
    #     existed_device_info.app_name = device_info.app_name
    #     existed_device_info.language = device_info.language
    #     existed_device_info.country_code = device_info.country_code
    #     existed_device_info.save
    #   else
    #     device_info.users_role = self.users_roles.of_role_name(self.class.name).try(:first)
    #     device_info.save
    #   end

    #   set_other_devices_offline(device_info.try(:device_id))
    #   clean_other_user_device_tokens(device_info.device_token)
    # end
  end

  # set other devices offline except the current device with the param device_id on the same user
  def set_other_devices_offline(device_id)
    # DeviceInfo.joins(:users_role => :role)
    #           .where("roles.name = ?", self.class.name.downcase)
    #           .where("users_roles.user_id = ?", self.id)
    #           .where("device_infos.device_id != ?", device_id)
    #           .update_all(is_online: false, authentication_token: nil)
  end

  def clean_other_user_device_tokens(device_token)
    # DeviceInfo.joins(:users_role => :role)
    #           .where(device_token: device_token)
    #           .where("roles.name = ?", self.class.name.downcase)
    #           .where("users_roles.user_id != ?", self.id).update_all(device_token: '')
  end

  def verify_sms_code(sms_code)
    if self.sms_confirmation_token
      if self.sms_confirmation_token == sms_code
        self.update(:sms_confirmation_token => nil, :sms_confirmed_at => Time.now.utc )
        return true
      else
        errors.add(:base, "Invalid SMS code!")
        return false
      end
    else
      errors.add(:base, "The sms code has been reseted. Please try to resend new sms code !")
      return false
    end    
  end

  def online!(device_id)
    self.try(:users_role).try(:online!, device_id)
  end

  def offline!(device_id)
    self.try(:users_role).try(:offline!, device_id)
  end


  def is_online(device_id)
    self.try(:users_role).try(:is_online?, device_id)
  end

  def current_device
    # users_role.try(:device_infos).try(:where, :is_online => true).try(:first) 
  end

  def new_sys_notif_count
    # users_role.try(:new_sys_notif_count)
  end
   

  module ClassMethods

    def normalize_phone(phone, country_code)
      if phone && country_code && GlobalPhone.validate(phone, country_code)
        GlobalPhone.normalize phone, country_code
      else
        phone
      end
    end


    def verify_user_authentication(params, headers)
      # todo: update for this to call params to the configration 
      if params[:login].include?("@")
        user = self.name.classify.constantize
                   .find_by(email: params[:login])
      else
        user = self.name.classify.constantize
                   .find_by(phone: normalize_phone(params[:login], params[:country_code]))
      end

      # dont check passwork for user login when user login without password
      if params[:password].present? 
        if user && user.valid_password?(params[:password])
          user.set_new_authentication_token(headers['Device-Id'])
          user
        else
          nil
        end
      else
        user
      end
    end

    def find_by_authentication_token(authentication_token)
      # users_role = UsersRole.with_authentication_token(authentication_token).try(:first)
      # if users_role
      #   if users_role.role.name == Supplier.name.downcase
      #     return Supplier.find_by_id(users_role.user_id)
      #   end 
      #   if users_role.role.name == Customer.name.downcase
      #     return Customer.find_by_id(users_role.user_id)
      #   end 
      # end
      nil
    end

    def authorize(params)
      # user = find_by_authentication_token(params[:authentication_token]) if params[:authentication_token]
      # return user
    end

    def authorize!(params, headers)
      # user = verify_user_authentication(params, headers)
      # if user
      #   if user.reset_password_token.blank? || user.reset_password_period_valid?
      #     # update device info
      #     UserService.update_device_info(user,headers)
      #     return user
      #   else
      #     raise Exceptions::CommonExceptions::Forbidden.new(message: I18n.t('errors.messages.temp_password_expired'))
      #   end
      # end
      # raise Exceptions::CommonExceptions::Invalid.new(message: I18n.t('devise.failure.invalid', authentication_keys: "phone, email"))
    end

  end

end
