require 'rails/generators'
require 'rails/generators/migration'

module Cable
    module Generators
      class PageGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
        # include Rails::Generators::ActiveModel
        source_root File.expand_path("../templates", __FILE__)
        desc "Generates a page model with the given NAME (if one does not exist) with a migration file and cable routes."
        # argument :model_name, :type => :string, :default => "menu"
        argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
        
        def self.next_migration_number(dirname)
         if ActiveRecord::Base.timestamped_migrations
           Time.now.utc.strftime("%Y%m%d%H%M%S")
         else
           "%.3d" % (current_migration_number(dirname) + 1)
         end
        end

        def create_migration_file
           migration_template 'migration.rb', "db/migrate/create_#{table_name}.rb"
        end       
        
        def create_model_file
           template 'model.rb' , "app/models/#{model_name}.rb"
        end
        
        private
        
        def model_name
          class_name.underscore
        end
        # hook_for :orm, :as => :model
        
      end
    end
end

