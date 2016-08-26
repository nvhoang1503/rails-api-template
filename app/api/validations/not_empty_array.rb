module Validations
  class NotEmptyArray < Grape::Validations::Base
    def validate_param!(attr_name, params)
      if params[attr_name].try(:length).to_i == 0 || params[attr_name].try(:[], 0) == ""
        raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: I18n.t('grape.errors.messages.presence')
      end
    end
  end
end