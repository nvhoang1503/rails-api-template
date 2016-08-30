require 'grape-swagger'

module API
  class Root < Grape::API
    prefix 'api'
    # format :json
    default_format :json

    
    resource :server_status do
      http_basic do |username, password|
        { 'TapseyApiMonitoring' => 'TapseyAPI547def670201fb0c4c7e36de97ca635c' }[username] == password
      end

      get do
        monitoring = Monitoring.is_working
        if monitoring[:working_status]
          monitoring.merge(status: 200)
        else
          monitoring.merge(status: 401)
        end
      end
    end

    

    before do
      set_locale
      devive_authenticate
    end

    after do
      if Rails.env.staging? || Rails.env.development? || Rails.env.test?
        Rails.logger.info "[API][CALL][#{request.ip}][END] #{request.url}" 
      end

      if Rails.env.development?
        # require 'rbtrace'
        # pid = Process.pid
        # system("rbtrace -p #{pid} -e \"load '#{Rails.root}/memory_tools/memory_trace_end.rb'\" ")
      end
    end

    helpers do
      def header_locale(item)
        item.split(",").first.split("-").first if item && item.split(",").first
      end

      def set_locale
        I18n.locale = params[:lang] || header_locale(headers['Accept-Language']) || I18n.default_locale
        # current_device_info.update(locale: I18n.locale) if current_device_info && current_device_info.locale != I18n.locale
      end


      # def user_authenticate!
      def device_info_authenticate!
        error!({:status  => 401, :message => "Device Authorization"}, 201) unless current_device_info
      end

      # def current_user
      def current_device_info
        @device_info ||= DeviceInfo.authorize params
      end

      def my_params
        ApiParams::Hash.new(params).as_rails_params
      end

      def my_permitted_params
        my_params.permit(*my_permitted_keys)
      end

      def validate_device_info_headers(*header_names)
        return if !header_names
        header_names.each do |header_name|
          if headers.try(:[], header_name).blank? && header_name != "Device-Token"
            raise Exceptions::CommonExceptions::RequiredParamsMissing
              .new(message: "#{header_name} header is missing",
            is_system_error: true)
          end
        end
      end

      def is_valid_device
        if (headers['Device-Id'].present? && headers['Device-Token'].present? && headers['Device-Type'].present? && headers['Accept-Language'].present?)
          true
        else
          error!({:status  => 401, :message => "User Authorization"}, 201)
        end
      end

      def devive_authenticate
        if set_access_token
          current_device_info
        else
          nil
        end
      end

      def set_access_token
        params[:authentication_token] ||= headers['Authorization']  # Should be headers['Authorization']
      end

    end

    add_swagger_documentation(
      info: {
        title: "Satv API root"
      },
      api_version: 'root', 
      base_path: '/api',
      add_version: false,
      mount_path: '/swagger_doc',
      hide_format: true, 
      hide_documentation_path: true,
    )

    mount API::V1::BaseApi

  end
end
