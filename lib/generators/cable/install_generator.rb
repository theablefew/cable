require 'rails/generators/migration'

module Cable
  module Generators
      class InstallGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        
        source_root File.expand_path("../../../../", __FILE__)
        desc "Sets up Cable with proper migrations"
        
        # invoke "migration", %(create_cable_settings site_title:string keywords:text analytics:string closure:text description:text contact_email:string footer_block_1:text footer_block_2:text copyright:string legal:text)
        class_option :orm, :type => :string, :default => "active_record"
        
        def self.next_migration_number(dirname)
         if ActiveRecord::Base.timestamped_migrations
           Time.now.utc.strftime("%Y%m%d%H%M%S")
         else
           "%.3d" % (current_migration_number(dirname) + 1)
         end
        end

        def create_migration_file
           migration_template 'lib/generators/templates/create_cable_settings.rb', "db/migrate/create_cable_settings.rb"
        end
        
        def copy_simple_nav
          copy_file 'config/admin_navigation.rb', 'config/admin_navigation.rb'
          copy_file 'config/navigation.rb', 'config/navigation.rb'
        end
        
        def install_routes
          route( 'cable_to :cable_settings' )
        end
        # hook_for :orm, :as => :migration
        
        def print_setup_instructions
          puts ""
          puts "Run rake db:migrate to complete setup."
          puts ""
          puts "To begin using Cable Menu and Pages use:"
          puts "rails generate cable:menu MENU_NAME"
          puts "rails generate cable:page PAGE_NAME field:type field:type ..."
          puts ""
        end

      protected
        #add protected methods here
      end
  end
end
