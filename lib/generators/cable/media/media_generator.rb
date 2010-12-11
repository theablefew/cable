require 'rails/generators/migration'

module Cable
  module Generators
      class MediaGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
        
         source_root File.expand_path("../templates", __FILE__)
         desc "Generates a Cable Menu with the given NAME (if one does not exist) plus a migration file"
         
         class_option :install, :type => :boolean, :default => false
         
         def create_table
           if options.install?
             migration_template 'migration.rb', "db/migrate/create_cable_media_assets.rb" 
           end
         end
         
         def create_model
           template 'model.rb' , "app/models/#{model_name}.rb"
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
         
      end
  end
end