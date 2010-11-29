module ActionDispatch::Routing
  class Mapper
   
    # Is equivelant to 
    #  
    # namespace :admin do
    #   resource :product
    # end
    #
    #
    
    def cable_to(*resources, &block)

      options = resources.extract_options!
      path = "admin"
      admin_namespace = { :path => path, :as => path, :module => path,
                           :shallow_path => path, :shallow_prefix => path }
      scope(admin_namespace) do 

        if apply_common_behavior_for(:resources, resources, options, &block)
          return self
        end

        resource_scope(Resource.new(resources.pop, options)) do
          yield if block_given?

          collection do
            get  :index if parent_resource.actions.include?(:index)
            post :create if parent_resource.actions.include?(:create)
          end

          new do
            get :new
          end if parent_resource.actions.include?(:new)

          member do
            get    :edit if parent_resource.actions.include?(:edit)
            get    :show if parent_resource.actions.include?(:show)
            put    :update if parent_resource.actions.include?(:update)
            delete :destroy if parent_resource.actions.include?(:destroy)
          end
        end
      end
      self
    end
    
    
  end
end