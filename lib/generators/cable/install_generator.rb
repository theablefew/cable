require 'rails/generators/migration'
require 'active_record'
module Cable
  module Generators
      class InstallGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        
        source_root File.expand_path("../../../../", __FILE__)
        desc "Sets up Cable with proper migrations"
        
        class_option :blocks, :type => :boolean, :default => true
        class_option :settings, :type => :boolean, :default => true
        class_option :locations, :type => :boolean, :default => true
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
        
        def create_locations
          if options.locations?
            begin
             migration_template 'lib/generators/templates/create_locations.rb', "db/migrate/create_locations.rb"
             copy_file 'lib/generators/templates/location_model.rb', 'app/models/location.rb'
             directory 'lib/generators/templates/partials', 'app/views/admin/partials'
            rescue

            end
         end
        end
        
        def copy_tiny_mce_config
          copy_file 'config/tiny_mce.yml', 'confit/tiny_mce.yml'
        end
        
        def create_blocks
          if options.blocks?
            begin
              migration_template 'lib/generators/templates/create_blocks.rb', 'db/migrate/create_blocks.rb'
            rescue
              copy_file 'lib/generators/templates/block.rb', 'app/models/block.rb'
              # copy_file 'lib/generators/templates/partials/_block.html.erb', 'app/views/admin/partials/_block.html.erb'
              # copy_file 'lib/generators/templates/partials/_block_form.html.erb', 'app/views/admin/partials/_block_form.html.erb'
            end
          end
        end
        
        def copy_simple_nav
          if options.simple_nav?
            if yes?("Would you like to install simple navigation?",:yellow)  
              generate("navigation_config")
              copy_file 'config/admin_navigation.rb', 'config/admin_navigation.rb'
              copy_file 'config/navigation.rb', 'config/navigation.rb'
            end
          end
        end
        
        def install_jquery
          if yes?("Dost thou require jquery?",:yellow)
            generate("jquery:install --ui")
          end
        end
        
        def install_initializer
          copy_file "lib/generators/templates/initializer.rb", "config/initializers/cable.rb"
        end
        
        def create_main_controller 
          copy_file 'lib/generators/templates/main_controller.rb', 'app/controllers/main_controller.rb'
        end
        
        def install_admin
          copy_file "app/controllers/admin_controller.rb", "app/controllers/admin_controller.rb"
          copy_file "app/views/layouts/admin.html.erb", 'app/views/layouts/admin.html.erb'
          directory 'app/views/layouts/admin', 'app/views/layouts/admin'
          directory "public/stylesheets/tinymce", "public/stylesheets/tinymce"
          copy_file 'app/views/admin/index.html.erb', 'app/views/admin/index.html.erb'
        end
        
        def install_default_resource_template
          directory 'app/views/main', 'app/views/main'
        end
        
        # def install_cocoon
        #     generate('cocoon:install')
        #     insert_into_file 'app/views/layouts/admin.html.erb', "<%= javascript_include_tag :cocoon %>\n", :before => '<%= yield :scripts %>'
        # end
        
        def create_seed_bed_directory
          empty_directory 'db/seeds'
        end
        
        def install_routes
        end
        
        def install_masks
          generate('cable:masks') if yes?("Would you like URL Masks module to be included?", :yellow)
        end
        # hook_for :orm, :as => :migration
        
        def print_setup_instructions
          say ""
          say "Run rake db:migrate to complete setup.", :yellow
          say ""
          say "To begin using Cable Menu and Resources use:", :green
          say "rails generate cable:menu MENU_NAME"
          say "rails generate cable:resource RESOURCE_NAME field:type field:type ..."
          say ""
        end
        
        
        
        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          if ActiveRecord::Base.timestamped_migrations
            [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
          else
            "%.3d" % next_migration_number
          end
        end

      protected
        #add protected methods here
      end
  end
end
