module API
  module V1
    class BaseApi < Grape::API
      include API::V1::ExceptionsHandler
      require_relative '../validations/not_empty_array'

      version ['v1'], using: :path, vendor: 'api'

      resource :test do
        desc "Returns ping."
        get "ping" do
          { ping: "ping v1" }
        end
      end

      mount API::V1::ExamplesApi
      mount API::V1::DeviceInfosApi

      add_swagger_documentation(
        info: {
          title: "SAtv API v1"
        },
        api_version: 'v1', 
        base_path: '/api/v1',
        add_version: false,
        mount_path: '/swagger_doc',
        hide_format: true, 
        hide_documentation_path: true,
      )
    end
  end
end
