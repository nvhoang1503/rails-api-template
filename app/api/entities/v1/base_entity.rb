module API
  module Entities
    module V1
      class BaseEntity < Grape::Entity

        # Return if:
        # Field belongs to 2 level filter and both field & child_field are not specifed in the represent method
        # Field belongs to 1 or 2 level filter and parent field are not specifed children
        # Field belongs 2 level filter and the child field is specifed (set true or not nil)
        def self.include_params(field, child_field = nil)
          lambda { |instance, options| 
                  (options.try(:[], self.class::ENTITY_TYPE).try(:[], field).blank? && child_field != nil) ||
                  (!options.try(:[], self.class::ENTITY_TYPE).try(:[], field).blank? && options.try(:[], self.class::ENTITY_TYPE).try(:[], field).class != Hash) ||
                  !options.try(:[], self.class::ENTITY_TYPE).try(:[], field).try(:[], child_field).blank?
                } 
        end

        format_with(:iso_timestamp) { |dt| dt.iso8601 if dt}
        format_with(:int_timestamp) { |dt| dt.to_i if dt}
        format_with(:date_int_timestamp) {|dt| dt.to_time(:utc).to_i if dt}
      end
    end
  end
end
