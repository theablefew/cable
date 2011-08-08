require 'active_record'
require 'rails/generators'
require 'rails/generators/migration'
module Cable
    module Generators
      class CacheGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        
        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          if ActiveRecord::Base.timestamped_migrations
            [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
          else
            "%.3d" % next_migration_number
          end
        end
        
        def create_migration_file
           migration_template 'migration.rb', "db/migrate/create_cable_cache_settings.rb"
        end
        
      end
    end
end
