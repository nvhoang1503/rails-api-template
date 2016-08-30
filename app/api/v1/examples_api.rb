module API
  module V1
    class ExamplesApi < API::V1::BaseApi
      
      resource :examples do 
        helpers do
          def my_permitted_keys
            [:name, :content]
          end
        end

        # api get list of examples
        desc 'List of examples'

        get do
          examples = Example.all
          API::Entities::V1::ExampleEntity.represent(examples).merge(status: 200, message: "List of examples !")
        end


        # api say hello
        desc 'Say hello api'

        get "say_hello" do
          obj = {
            :status   => 200,
            :message  => "Hello you!"
          }
        end

        # api get example details
        desc 'Get example detail'
        params do
          requires :id, type: Integer, desc: 'Example ID'
        end

        get ":id" do
          example = Example.find_by_id(params[:id]) 
          API::Entities::V1::ExampleEntity.represent(example).merge(status: 200, message: "Example details !")
        end 


        # api create new example
        desc "Create example"
        params do
          requires :authentication_token, type: String, desc: 'Device authentication token'
          requires :name, type: String, desc: 'Name of Example'
          optional :content, type: String, desc: 'Content of Example '
        end

        post do
          device_info_authenticate!
          example = Example.new my_permitted_params
          if example.save
            API::Entities::V1::ExampleEntity.represent(example).merge(status: 200, message: "Create example successful !")
          else
            {
              status: 400,
              message: "Error ..."
            }
          end
        end


        # edit example
        desc "Edit an example"
        params do
          requires :authentication_token, type: String, desc: 'Device authentication token'
          requires :id, type: Integer, desc: 'ID of Example'
          requires :name, type: String, desc: 'Name of Example '
          optional :content, type: String, desc: 'Content of Example'
        end
        put ":id" do
          device_info_authenticate!
          example = Example.find_by_id(params[:id])
          if example.update(my_permitted_params)
            API::Entities::V1::ExampleEntity.represent(example).merge(status: 200, message: "Update example successful !")
          else
            {
              status: 400,
              message: "Error ..."
            }
          end
        end


        # delete example
        desc 'Delete example'
        params do
          requires :id, type: Integer, desc: 'ID of Example'
        end

        delete ":id" do
          example = Example.find_by_id(params[:id])
          if example.destroy
            {
              status: 200,
              message: "Delete example successful!"
            }
          else
            {
              status: 400,
              message: "Error ..."
            }
          end
        end

      end
    end
  end
end
