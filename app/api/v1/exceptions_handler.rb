module API
  module V1
    module ExceptionsHandler
      extend ActiveSupport::Concern

      included do
        rescue_from :all do |e|
          status, message = case e
          when ActiveRecord::RecordInvalid
           # [422, e.record.errors.full_messages.join(', ')]
           [201, {:status => 422, :message => e.record.errors.full_messages.join(', ')}]
          when Grape::Exceptions::ValidationErrors
           [201, {:status => 400, 
                  :message => GrapeUtils::ExceptionUtils.convert_full_error_messages(e.errors).join(', '), 
                  :full_messages => GrapeUtils::ExceptionUtils.convert_full_error_messages(e.errors),
                  :attributes => e.errors.keys.flatten}]
          when Exceptions::CommonExceptions::CommonException
            [201, {:status => e.try(:status), :message => e.try(:message), :field => e.try(:field)}]
          else
            # [400, e.message]
            [201, {:status => 400, :message => e.message}]
          end
          Grape::API.logger.error e

          error_response message: message, status: status
        end
      end
    end
  end
end
