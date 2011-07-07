require 'rails/generators'
require 'rails/generators/migration'     
require 'rails/generators/active_model'
require 'active_record'
require 'rails/generators'
require 'rails/generators/migration'
module Cable
    module Generators
      class MasksGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
        # include Rails::Generators::ActiveModel
        source_root File.expand_path("../templates", __FILE__)
        desc "Generates a Cable UrlMask with the given NAME (if one does not exist) plus a migration file"
        # argument :model_name, :type => :string, :default => "url_mask"
        argument :name, :type => :string, :default => "url_mask"
        class_option :controller, :type => :boolean, :default => true
        class_option :model, :type => :boolean, :default => true
        class_option :migration, :type => :boolean, :default => true
        
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
        
        def copy_url_mask_fields
          directory 'erb', 'app/views/admin/url_masks'
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
