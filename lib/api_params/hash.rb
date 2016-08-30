module ApiParams
  class Hash
    attr_reader :value

    def initialize(value)
      @value = value.dup

      @value.each do |k, v|
        @value[k] = Field.new(v).value
      end
    end

    def as_rails_params
      ActionController::Parameters.new @value.except(:route_info)
    end
  end
end
