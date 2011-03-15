require 'rails/generators/migration'

module Cable
  module Generators
      class InstallGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        
        source_root File.expand_path("../../../../", __FILE__)
        desc "Sets up Cable with proper migrations"
        
        class_option :blocks, :type => :boolean, :default => true
        class_option :settings, :type => :boolean, :default => true
        class_option :simple_nav, :type => :boolean, :default => true
        class_option :admin, :type => :boolean, :default => true
        # invoke "migration", %(create_cable_settings site_title:string keywords:text analytics:string closure:text description:text contact_email:string footer_block_1:text footer_block_2:text copyright:string legal:text)
        class_option :orm, :type => :string, :default => "active_record"

        def create_settings
          if options.settings?
            begin
             migration_template 'lib/generators/templates/create_cable_settings.rb', "db/migrate/create_cable_settings.rb"
             route( 'cable_to :cable_settings' )
            rescue

            end
         end
        end
        
        def create_blocks
          if options.blocks?
            begin
              migration_template 'lib/generators/templates/create_blocks.rb', 'db/migrate/create_blocks.rb'
            rescue
              copy_file 'lib/generators/templates/block.rb', 'app/models/block.rb'
              copy_file 'lib/generators/templates/partials/_block.html.erb', 'app/views/admin/partials/_block.html.erb'
              copy_file 'lib/generators/templates/partials/_block_form.html.erb', 'app/views/admin/partials/_block_form.html.erb'
            end
          end
        end
        
        def copy_simple_nav
          if options.simple_nav?
            if yes?("Would you like to install simple navigation?") 
              generate("navigation_config")
              copy_file 'config/admin_navigation.rb', 'config/admin_navigation.rb'
                # copy_file 'config/navigation.rb', 'config/navigation.rb'
            end
          end
        end
        
        def install_jquery
          if yes?("Would you like to install jquery?")
            generate("jquery:install --ui")
          end
        end
        
        def install_initializer
          copy_file "lib/generators/templates/initializer.rb", "config/initializers/cable.rb"
        end
        
        def install_admin
          copy_file "app/views/layouts/admin.html.erb", 'app/views/layouts/admin.html.erb'
        end
        
        def install_routes
        end
        # hook_for :orm, :as => :migration
        
        def print_setup_instructions
          puts ""
          puts "Run rake db:migrate to complete setup."
          puts ""
          puts "To begin using Cable Menu and Pages use:"
          puts "rails generate cable:menu MENU_NAME"
          puts "rails generate cable:resource PAGE_NAME field:type field:type ..."
          puts ""
        end
        
        def self.next_migration_number(dirname)
         if ActiveRecord::Base.timestamped_migrations
           Time.now.utc.strftime("%Y%m%d%H%M%S") + (rand(6) + rand(5)).to_s
         else
           "%.3d" % (current_migration_number(dirname) + 1)
         end
        end

      protected
        #add protected methods here
      end
  end
end
