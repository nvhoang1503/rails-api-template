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
      #Maintenance mode
      if !Turnout::MaintenanceFile.find.nil?
        error!({
          "status": 403,
          "message": I18n.t('errors.messages.maintenance')
        }, 200)
      end

      if Rails.env.staging? || Rails.env.development? || Rails.env.test?
        Rails.logger.info "[API][CALL][#{request.ip}][START] #{request.url}" 
      end

      if Rails.env.development?
        # require 'rbtrace'
        # pid = Process.pid
        # system("rbtrace -p #{pid} -e \"load '#{Rails.root}/memory_tools/memory_trace_start.rb'\" ")
      end

      # set_locale
      set_access_token
      set_locale
      device_tracking
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
        I18n.locale = params[:lang] || headers['Locale'] || header_locale(headers['Accept-Language']) || I18n.default_locale
        current_user.update(locale: I18n.locale) if current_user && current_user.locale != I18n.locale
      end


      def user_authenticate!
        error!({:status  => 401, :message => "User Authorization"}, 201) unless current_user
      end

      def current_user
        @user ||= User.authorize params
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


      def device_tracking
        country_code = AppSettings.new(request: request).current_country_code
        if (headers['Device-Token'] || headers['Device-Id']) && current_user
          current_user.update_device_info(
            DeviceInfo.new({
              device_type: headers['Device-Type'],
              device_name: headers['Device-Name'],
              device_id: headers['Device-Id'],
              device_token: headers['Device-Token'],
              os_version: headers['Os-Version'],
              screen_dpi: headers['Screen-Dpi'],
              app_version: headers['App-Version'],
              app_name: headers['App-Name'],
              language: headers['Accept-Language'],
              country_code: country_code
            })
          )
        else
          device_info = DeviceInfo.where(device_id: headers['Device-Id']).anonymous.first || DeviceInfo.new()
          device_info.update_attributes!(
            device_type: headers['Device-Type'],
            device_name: headers['Device-Name'],
            device_id: headers['Device-Id'],
            device_token: headers['Device-Token'],
            os_version: headers['Os-Version'],
            screen_dpi: headers['Screen-Dpi'],
            app_version: headers['App-Version'],
            app_name: headers['App-Name'],
            language: headers['Accept-Language'],
            country_code: country_code
          )

          device_info.save
        end
      end

      def set_access_token
        params[:authentication_token] ||= params[:api_key] ||= headers['Authorization']  # Should be headers['Authorization']
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
