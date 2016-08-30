module ApiParams
  class Field
    def initialize(value)
      @value = value
    end

    def value
      case @value
      when Hashie::Mash
        if @value[:tempfile].is_a?(Tempfile)
          ActionDispatch::Http::UploadedFile.new @value
        else
          Hash.new(@value).value
        end
      when Array
        @value.map { |v| Field.new(v).value }
      else
        @value
      end
    end
  end
end
