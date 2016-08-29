module Exceptions
  module CommonExceptions
    class CommonException < StandardError
    end
    
    class PersistException < CommonException
      attr_reader :message
      attr_reader :status
      def initialize(hash)
        @message = hash[:message]
        @status = hash[:status] || 400
      end
      def message
        if !@message
          "Persist error"
        else
          @message
        end
      end
    end

    class NotFound < CommonException
      attr_reader :message
      attr_reader :status
      def initialize(hash)
        @message = hash[:message]
        @status = hash[:status] || 400
      end
      def message
        if !@message
          "Item not found."
        else
          @message
        end
      end
    end

    class Forbidden < CommonException
      attr_reader :message
      attr_reader :status
      def initialize(hash)
          @message = hash[:message]
          @status = hash[:status] || 400
      end
      def message
        if !@message
          "Forbidden."
        else
          @message
        end
      end
    end

    class Invalid < CommonException
      attr_reader :message
      attr_reader :status
      attr_reader :errors
      attr_reader :is_system_error
      attr_reader :field
      def initialize(hash)
          @message = hash[:message]
          @status = hash[:status] || 400
          @errors = hash[:errors] || []
          @field = hash[:field]
          @is_system_error = hash[:is_system_error] || false
      end
      def message
        if !@message
          "Invalid."
        else
          @message
        end
      end

      def errors
        @errors
      end

    end

    class RequiredParamsMissing < CommonException
      attr_reader :message
      attr_reader :status
      attr_reader :errors
      attr_reader :is_system_error
      def initialize(hash)
          @message = hash[:message]
          @status = hash[:status] || 400
          @errors = hash[:errors] || []
          @is_system_error = hash[:is_system_error] || false
      end
      def message
        if !@message
          "Invalid."
        else
          @message
        end
      end

      def errors
        @errors
      end
    end
    
  end
end
