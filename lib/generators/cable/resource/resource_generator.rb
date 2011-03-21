require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/resource_helpers'
require 'active_record'
require 'rainbow'
# require 'rails/generators/controller_generator'
module Cable
    module Generators
      class ResourceGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
        include Rails::Generators::ResourceHelpers
        
        source_root File.expand_path("../templates", __FILE__)
        desc "Generates a Cable Resource with the given NAME (if one does not exist) with a migration file"
        
        argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
        
        class_option :views,      :type => :boolean, :default => true, :desc => "Include Admin."
        class_option :migration,  :type => :boolean, :default => true
        class_option :model,      :type => :boolean, :default => true
        class_option :routes,     :type => :boolean, :default => true
        class_option :controller, :type => :boolean, :default => true
        class_option :orm,        :type => :string,  :default => "active_record"
 
        def create_migration_file
           migration_template 'migration.rb', "db/migrate/create_#{table_name}.rb" if options.migration? and yes?("Would you like to generate a migration?".color(:yellow))
        end       
        
        def create_model_file
           template 'model.rb' , "app/models/#{model_name}.rb" if options.model? and yes?("Would you like to generate a model?".color(:yellow))
        end
        
        def create_controller_file
          if options.controller?
            template 'controller.rb' , "app/controllers/admin/#{file_name.pluralize}_controller.rb" if yes?("Would you like to generate a controller?".color(:yellow))
          end
        end
        
        def create_scaffold
          if options.views?
            if yes?("Would you like Cable to generate views for #{model_name.capitalize}?".color(:yellow))
              template 'erb/scaffold/_form.html.erb', "app/views/admin/#{plural_table_name}/_#{singular_table_name}.html.erb"
              template 'erb/scaffold/index.html.erb', "app/views/admin/#{plural_table_name}/index.html.erb"
              template 'erb/scaffold/edit.html.erb', "app/views/admin/#{plural_table_name}/edit.html.erb"
              template 'erb/scaffold/new.html.erb', "app/views/admin/#{plural_table_name}/new.html.erb"
              template 'erb/scaffold/show.html.erb', "app/views/admin/#{plural_table_name}/show.html.erb"
            end
          end
        end
        
        def install_route
          route("cable_to :#{plural_table_name}") if options.routes? and yes?("Would you like to generate routes for #{model_name.capitalize}?".color(:yellow))
        end
        
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
        # hook_for :orm, :as => :model
        
      end
    end
end

