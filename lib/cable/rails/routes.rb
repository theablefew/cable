module ActionDispatch::Routing
  class Mapper
   
    def cable_to(*resources, &block)
      options = resources.extract_options!

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

      self
    end
    
    
  end
end

# def devise_for(*resources)
#       options = resources.extract_options!
# 
#       options[:as]          ||= @scope[:as]     if @scope[:as].present?
#       options[:module]      ||= @scope[:module] if @scope[:module].present?
#       options[:path_prefix] ||= @scope[:path]   if @scope[:path].present?
#       options[:path_names]    = (@scope[:path_names] || {}).merge(options[:path_names] || {})
# 
#       resources.map!(&:to_sym)
# 
#       resources.each do |resource|
#         mapping = Devise.add_mapping(resource, options)
# 
#         begin
#           raise_no_devise_method_error!(mapping.class_name) unless mapping.to.respond_to?(:devise)
#         rescue NameError => e
#           raise unless mapping.class_name == resource.to_s.classify
#           warn "[WARNING] You provided devise_for #{resource.inspect} but there is " <<
#             "no model #{mapping.class_name} defined in your application"
#           next
#         rescue NoMethodError => e
#           raise unless e.message.include?("undefined method `devise'")
#           raise_no_devise_method_error!(mapping.class_name)
#         end
# 
#         routes  = mapping.routes
#         routes -= Array(options.delete(:skip)).map { |s| s.to_s.singularize.to_sym }
# 
#         devise_scope mapping.name do
#           yield if block_given?
#           with_devise_exclusive_scope mapping.fullpath, mapping.name do
#             routes.each { |mod| send("devise_#{mod}", mapping, mapping.controllers) }
#           end
#         end
#       end
#     end