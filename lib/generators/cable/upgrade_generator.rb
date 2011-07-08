require 'rails/generators/migration'
require 'active_record'
module Cable
  module Generators
      class UpgradeGenerator < Rails::Generators::Base
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

        CABLE_PAGE = "Cable::Page"
        CABLE_RESOURCE = "Cable::Resource"
        CABLE_MENU_LEGACY = "Cable::Menu::Base"
        CABLE_MENU = "Cable::Menus::Menu"
        
        def check_for_cable_page
          
           say( "Checking for instance of Cable::Page...", :yellow )
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
          say( "Checking for legacy Cable::Menu...", :yellow)
          lines = grep_for( CABLE_MENU_LEGACY, 'app/models' )
          files = extract_filenames_from_grep( lines )
          unless files.empty?
            say_files_found( files )
            
            say("Cable::Menu::Base has changed to Cable::Menus::Menu\n", :red)
            Array(files).each{|f| replace_cable_menu(f) } if yes?("Would you like to replace these instances with Cable::Menus::Menu?", :yellow)
            
          else
            say( "None found.\n", :green)
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
        
        def say_files_found( files )
           say("")
           say("Found the following files:", :red)
           say("")
           Array(files).each do |f|
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
        
        
      end
  end
end
