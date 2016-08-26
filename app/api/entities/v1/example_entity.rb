module API
  module Entities
    module V1
      class ExampleEntity < API::Entities::V1::BaseEntity
        root 'data', 'object'

        expose :id,
              :name,
              :content

        with_options(format_with: :int_timestamp) do
          expose :created_at
          expose :updated_at
        end
      end
    end
  end
end
