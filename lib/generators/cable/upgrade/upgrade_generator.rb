require 'rails/generators/migration'
require 'active_record'
module Cable
  module Generators
      class UpgradeGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        
        source_root File.expand_path("../../../../../", __FILE__)
        desc "Sets up Cable with proper migrations"
        
        class_option :blocks, :type => :boolean, :default => true
        class_option :settings, :type => :boolean, :default => true
        class_option :locations, :type => :boolean, :default => true
        class_option :simple_nav, :type => :boolean, :default => true
        class_option :admin, :type => :boolean, :default => true
        # invoke "migration", %(create_cable_settings site_title:string keywords:text analytics:string closure:text description:text contact_email:string footer_block_1:text footer_block_2:text copyright:string legal:text)
        class_option :orm, :type => :string, :default => "active_record"

        CABLE_PAGE = "Cable::Page"
        CABLE_RESOURCE = "Cable::Resource"
        CABLE_MENU_LEGACY = "Cable::Menu::Base"
        CABLE_MENU = "Cable::Menus::Menu"
        ACTS_AS_CABLE = "acts_as_cable"
        PREVENT_DELETION = "prevent_deletion"
        
        def display_banner
          puts Cable::Helpers::TerminalHelper.version
        end
        
        def upgrade_cable_views
          say "\nChecking for legacy view files...", :white
          
          lines = grep_for( ACTS_AS_CABLE , "app/models/*")
          files = extract_filenames_from_grep( lines )
          models = files.collect{|d| d.scan(/\/(\w+).rb$/)}.flatten.collect(&:tableize)
          models.each do |model|
            say "Views for #{model.classify}"
            say_files_found( Dir["app/views/admin/#{model}/*.html.erb"] )
            say ""
          end
          Array(models).each{|f| backup_legacy_cable( "app/views/admin/#{f}" ) } if yes?("Would you like to backup these files before running cable:install?", :yellow )
        end
        
        def check_for_cable_page
          
           say( "\nChecking for instance of Cable::Page...", :white )
           lines = grep_for( CABLE_PAGE , "app/**/*")
           files = extract_filenames_from_grep( lines )
           
           unless files.empty?
             say_files_found( files )
             Array(files).each{|f| replace_cable_page(f) } if yes?("Would you like to replace these instances with Cable::Resource?", :yellow)
           else
             say("None found.\n", :green)
           end
        end
        
        def check_for_old_menu_system
          say( "\nChecking for legacy #{CABLE_MENU_LEGACY}...", :white)
          lines = grep_for( CABLE_MENU_LEGACY, 'app/models' )
          files = extract_filenames_from_grep( lines )
          unless files.empty?
            say_files_found( files )
            
            say("#{CABLE_MENU_LEGACY} has changed to #{CABLE_MENU}\n", :red)
            Array(files).each{|f| replace_cable_menu(f) } if yes?("Would you like to replace these instances with Cable::Menus::Menu?", :yellow)
            
          else
            say( "None found.\n", :green)
          end
        end
        
        
        def check_for_prevent_deletion_method
          say( "\nChecking for deprecated methods on #{CABLE_MENU}...", :white)
          
          lines = grep_for( PREVENT_DELETION , 'app/models')
          files = extract_filenames_from_grep( lines )
          unless files.empty?
            say_files_found( files )
            
            say("prevent_deletion is deprecated and will no longer be used. You must delete it.\n", :red)
            Array(files).each{|f| remove_prevent_deletion(f) } if yes?("Would you like to remove prevent_deletion?", :yellow)
            
          else
            say( "None found.\n", :green)
          end
        end

        def create_locations
          say("\nPreparing to install Cable::Locations.", :white)
          if yes?( "Do you want to install and migrate Cable::Locations?", :yellow)
            begin
             migration_template 'lib/generators/templates/create_locations.rb', "db/migrate/create_locations.rb"
             copy_file 'lib/generators/templates/location_model.rb', 'app/models/location.rb'
             directory 'lib/generators/templates/partials', 'app/views/admin/partials'
             run('rake db:migrate') 
            rescue

            end
            
          end
        end
        
        def install_admin
          say( "\nPreparing to install newest admin views. Be careful! This will overwrite\n", :white )
          say( "\tapp/controllers/admin_controller.rb" , :cyan )
          say( "\tapp/views/layouts/admin.html.erb", :cyan )
          say( "\tapp/views/layouts/admin directory", :cyan )
          say( "\tpublic/stylesheets/tinymce", :cyan )
          say( "\tapp/views/admin/index.html.erb", :cyan )
          say( "\tapp/helpers/admin/menus_helper.rb", :cyan )
          say( "\tpublic/javascripts/admin.js", :cyan)
          say ""
          if yes?( "Do you want to regenerate Cable admin layouts and Cable controller?", :yellow )
           
            backup_file( "app/controllers/admin_controller.rb" )
            backup_file( "app/views/layouts/admin.html.erb" )
            backup_file( "public/stylesheets/tinymce/custom_rich_editor.css")
            backup_file( "app/views/admin/index.html.erb")
            backup_file( "app/views/layouts/admin/_dual_column_layout.html.erb")
            backup_file( "app/views/layouts/admin/_single_column_layout.html.erb")
            backup_file( "app/helpers/admin/menus_helper.rb")
            backup_file( "public/javascripts/admin.js")
            
            copy_file "app/controllers/admin_controller.rb", "app/controllers/admin_controller.rb"
            copy_file "app/views/layouts/admin.html.erb", 'app/views/layouts/admin.html.erb'
            directory 'app/views/layouts/admin', 'app/views/layouts/admin'
            directory "public/stylesheets/tinymce", "public/stylesheets/tinymce"
            copy_file 'app/views/admin/index.html.erb', 'app/views/admin/index.html.erb'
            # copy_file 'app/helpers/admin/menus_helper.rb','app/helpers/admin/menus_helper.rb'
            copy_file 'public/javascripts/admin.js', 'public/javascripts/admin.js'
          end
        end
    
        def copy_tiny_mce_config
          copy_file 'config/tiny_mce.yml', 'config/tiny_mce.yml' if yes?( "Would you like to copy Cable's default tiny_mce.yml configuration?", :yellow )
        end
        
        def install_default_resource_template
          say( "\nPreparing to install default resource template.", :white)
          say( "\tapp/views/main/show.html.erb" , :cyan )
          say( "\tapp/views/main/templates/_default.html.erb", :cyan)
          say ""
          if yes?( "This operation will backup all the files it replaces. Do you want to regenerate the default resource templates?", :yellow )
            backup_file( 'app/views/main/show.html.erb' )
            backup_file( 'app/views/main/templates/_default.html.erb')
            directory 'app/views/main', 'app/views/main' 
          end
          
        end
        
        def create_seed_bed_directory
          say("\nPreparing to create SeedBed directory.", :white)
          say( "db/seeds", :cyan )
          say ""
          empty_directory 'db/seeds' if yes?("Do you want to generate SeedBed directory?", :yellow )
        end
        
        def install_masks
          say( "\nPreparing to install Cable::UrlMasks with rails g cable:masks" , :white)
          if yes?("Would you like to install and migrate Cable::UrlMasks?", :yellow)
            generate('cable:masks') 
            run('rake db:migrate') 
          end
        end
        
        def backup_table
          say "\nPreparing to backup menus table.", :white
          say "Does menus_backup exist? #{ActiveRecord::Base.connection.table_exists?(:menus_backup) ? 'yes' : 'no' }"
          unless ActiveRecord::Base.connection.table_exists? :menus_backup
            say "Creating a backup of the menus table called menus_backup", :green
            ActiveRecord::Base.connection.execute( "CREATE TABLE menus_backup LIKE menus" )
            ActiveRecord::Base.connection.execute( "INSERT menus_backup SELECT * FROM menus" )
          end
        end
        
        def create_locations_from_legacy_menu
          say "\nPreparing to convert existing urls to Cable::Locations", :white
          migration_template 'lib/generators/cable/upgrade/templates/add_location_id_to_menus.rb', "db/migrate/add_location_id_to_menus.rb"
          begin
            run('rake db:migrate --trace') if yes? "Do you want to begin the location migration?", :yellow
          rescue
            
          end
        end
        
        def migrate_menu_table
          say "\nPreparing to migrate the menu model table.", :white
          migration_template 'lib/generators/cable/upgrade/templates/migrate_from_legacy_menu.rb', "db/migrate/migrate_from_legacy_menu.rb"
          if yes? "Do you want to begin the menu migration?"
            run('rake db:migrate') 
          else
            say "\nA migration has been created. Run rake db:migrate to complete this task.\n", :green
          end
        end
        
        def install_menus
          say "\nPreparing to install updated menu views, controller, and model", :white
          if yes?( "Would you like to run cable:menu generator?", :yellow )
            generate( 'cable:menu Menu --no-migration --no-model --no-routes')
          else
            say "\nRun rails g cable:menu Menu --no-migration --no-model --no-routes to regenerate menu assets\n", :green
          end
        end
        
        def show_exit
          say "\nCable v1.0.0 Upgrade complete!".color( :green ).bright
          say "\n\nYou will need to regenerate your Cable::Resource views to receive location and menu views in resource admin.\n\n"
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
      
        def replace_cable_page( fil_name )
          replace_in_file( fil_name, CABLE_PAGE, CABLE_RESOURCE )
        end
        
        def replace_cable_menu( fil_name )
          replace_in_file( fil_name, CABLE_MENU_LEGACY, CABLE_MENU )
        end
        
        def replace_in_file( fil_name, match, replace )
          text = File.read( fil_name )
          File.open(fil_name, "w") {|file| file.puts text.gsub( match, replace )}
        end
        
        def remove_prevent_deletion( fil_name )
          rxp = /#{Regexp.quote(PREVENT_DELETION)}.+$/
          replace_in_file( fil_name, rxp , "" )
        end
        
        def say_files_found( files )
           say("")
           
           arr_of_files = files.kind_of?(Array) ? files : Array(files)
           arr_of_files.each do |f|
              say "\t- #{f}", :red
           end
           say("")
        end
        
        #add protected methods here
        def grep_for(text, where = "./", double_quote = false, perl_regex = false)
          # If they're on Windows, they probably don't have grep.
          @probably_has_grep ||= (Config::CONFIG['host_os'].downcase =~ /mswin|windows|mingw/).nil?

          # protect against double root paths in Rails 3
          where.gsub!(Regexp.new(base_path),'')

          lines = if @probably_has_grep
            find_with_grep(text, base_path + where, double_quote, perl_regex)
          else
            find_with_rak(text, base_path + where, double_quote)
          end

          # ignore comments
          lines.gsub /^(\/[^:]+:)?\s*#.+$/m, ""
        end

        # Sets a base path for finding files; mostly for testing
        def base_path
          Dir.pwd + "/"
        end

        # Use the grep utility to find a string in a set of files
        def find_with_grep(text, where, double_quote, perl_regex = false)
          value = ""
          # Specifically double quote for finding 'test_help'
          command = if double_quote
                      "grep -rH \"#{text}\" #{where} | grep -v \.svn"
                    else
                      "grep -rH '#{text}' #{where} | grep -v \.svn"
                    end

          Open3.popen3(command) do |stdin, stdout, stderr|
            value = stdout.read
          end
          value
        end
        
        def extract_filenames_from_grep(output)
          return [] if output.empty?

          output.split("\n").map do |fn|
            if m = fn.match(/^(.+?):/)
              m[1]
            end
          end.compact.uniq
        end
        
        
        def backup_legacy_cable( dir )

          files = Dir["#{dir}/*.html.erb"]
          

          puts
          files.each do |f|
            backup_file( f)
          end

          puts

        end
        
        def backup_file( fil )
          if File.exist?(fil)
            say "backing up #{fil} to #{fil}.cable_old", :cyan
            FileUtils.cp(fil, "#{fil}.cable_old")
          end
        end
        
      end
  end
end
