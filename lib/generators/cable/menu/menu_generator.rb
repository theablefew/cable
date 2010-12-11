require 'rails/generators'
require 'rails/generators/migration'     
require 'rails/generators/active_model'
module Cable
    module Generators
      class MenuGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
        # include Rails::Generators::ActiveModel
        source_root File.expand_path("../templates", __FILE__)
        desc "Generates a Cable Menu with the given NAME (if one does not exist) plus a migration file"
        # argument :model_name, :type => :string, :default => "menu"
        argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
        class_option :controller, :type => :boolean, :default => true
        class_option :model, :type => :boolean, :default => true
        class_option :migration, :type => :boolean, :default => true
        class_option :views, :type => :boolean, :default => true
        class_option :routes, :type => :boolean, :default => true
        def create_migration_file
          if options.migration?
           migration_template 'migration.rb', "db/migrate/create_#{model_name.pluralize}.rb"
         end
        end
        
        def create_model_file
          if options.model?
           template 'model.rb' , "app/models/#{model_name}.rb"
         end
        end
        
        def create_controller_file
          if options.controller?
            template 'controller.rb', "app/controllers/admin/#{model_name.pluralize}_controller.rb"
          end
        end
        
        def create_views
          if options.views?
            template 'erb/menus/_edit_remote.html.erb', "app/views/admin/#{plural_table_name}/_edit_remote.html.erb"
            template 'erb/menus/_menu.html.erb', "app/views/admin/#{plural_table_name}/_menu.html.erb"
            template 'erb/menus/edit.html.erb', "app/views/admin/#{plural_table_name}/edit.html.erb"
            template 'erb/menus/index.html.erb', "app/views/admin/#{plural_table_name}/index.html.erb"
            template 'erb/menus/new.html.erb', "app/views/admin/#{plural_table_name}/new.html.erb"
            template 'erb/menus/show.html.erb', "app/views/admin/#{plural_table_name}/show.html.erb"
            template 'erb/menus/table.html.erb', "app/views/admin/#{plural_table_name}/table.html.erb"
            copy_file 'erb/partials/_menu_fields.html.erb', 'app/views/admin/partials/_menu_fields.html.erb'
          end
        end
        
        def create_routes
          
          route_string = <<EOF
cable_to :#{plural_table_name} do |menu|
  collection do
    post :update_tree
    get :rebuild
    post :edit_remote
    get :table
    get "edit_tree(/:id)", :action => :edit_tree
  end
end
EOF
          route( route_string )
        
        end
        
        # Implement the required interface for Rails::Generators::Migration.
        # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
        def self.next_migration_number(dirname)
         if ActiveRecord::Base.timestamped_migrations
           Time.now.utc.strftime("%Y%m%d%H%M%S")
         else
           "%.3d" % (current_migration_number(dirname) + 1)
         end
        end
        
        private
        
        def model_name
          class_name.underscore
        end
        # hook_for :orm, :as => :migration
        # hook_for :orm, :as => :model
        
      end
    end
end
