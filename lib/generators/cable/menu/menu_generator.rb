require 'rails/generators'
require 'rails/generators/migration'     
require 'rails/generators/active_model'
require 'active_record'
require 'rainbow'

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
           migration_template 'migration.rb', "db/migrate/create_#{model_name.pluralize}.rb" if yes?("Would you like to generate a migration?".color(:yellow))
         end
        end
        
        def create_model_file
          if options.model?
           template 'model.rb' , "app/models/#{model_name}.rb" if yes?("Would you like to generate a model?".color(:yellow))
         end
        end
        
        def create_controller_file
          if options.controller?
            template 'controller.rb', "app/controllers/admin/#{model_name.pluralize}_controller.rb" if yes?("Would you like to generate a controller?".color(:yellow))
          end
        end
        
        def create_views
          if options.views?
            if yes?( "Would you like Cable to generate menu views?".color(:yellow))
              Dir.glob(File.expand_path("../templates", __FILE__) + '/erb/menus/*.erb') do |rb_file|
                template rb_file, "app/views/admin/#{plural_table_name}/#{File.basename(rb_file)}"
              end
              copy_file 'erb/partials/_menu_fields.html.erb', 'app/views/admin/partials/_menu_fields.html.erb'
            end
          end
        end
        
        def create_routes
          
          route_string = <<EOF
cable_to :#{plural_table_name} do |menu|
  collection do
    post :sort
  end
end
EOF
          route( route_string ) if yes?("Would you like to generate routes?".color(:yellow))
        
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
