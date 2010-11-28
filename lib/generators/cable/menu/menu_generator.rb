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
        
        # Implement the required interface for Rails::Generators::Migration.
        # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
        def self.next_migration_number(dirname)
         if ActiveRecord::Base.timestamped_migrations
           Time.now.utc.strftime("%Y%m%d%H%M%S")
         else
           "%.3d" % (current_migration_number(dirname) + 1)
         end
        end

        def create_migration_file
           migration_template 'migration.rb', "db/migrate/create_#{model_name.pluralize}.rb"
        end
        
        def create_model_file
           template 'model.rb' , "app/models/#{model_name}.rb"
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

