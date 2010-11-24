module Cable
  module Generators
    # module Admin
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("../../../../", __FILE__)
        desc "Copies all Cable admin views to your application."

        argument :scope, :required => false, :default => nil,
                         :desc => "The scope to copy views to"

        # class_option :template_engine, :type => :string, :aliases => "-t",
                                       # :desc => "Template engine for the views. Available options are 'erb' and 'haml'."

        def copy_views
            copy_file "app/controllers/cable/admin_controller.rb", "app/controllers/admin_controller.rb"
            copy_file "app/helpers/admin_helper.rb", "app/helpers/admin_helper.rb"
            directory "app/views/cable/admin", "app/views/#{scope || :admin}"
            directory "app/views/cable/layouts", "app/views/layouts"
            directory "lib/generators/cable/templates/javascripts", "public/javascripts"
            directory "lib/generators/cable/templates/stylesheets", "public/stylesheets"
        end
        
        def install_routes
          route("match '/admin(/:action(/:id))' => 'admin'")
        end


      protected
        #add protected methods here
      end
    # end
  end
end