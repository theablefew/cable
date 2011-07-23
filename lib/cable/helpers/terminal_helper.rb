module Cable
  module Helpers
    module TerminalHelper
      
      def self.banner
        banner_text = <<-'HERE'
                   _     _      
          ___ __ _| |__ | | ___ 
         / __/ _` | '_ \| |/ _ \
        | (_| (_| | |_) | |  __/
         \___\__,_|_.__/|_|\___|
        HERE
        banner_text.color('399DDB')
      end
      
      def self.able_stamp
        "The Able Few".color('399DDB').bright + " | theablefew.com"
      end
      
      def self.version
        puts "\n"
        puts Cable::Helpers::TerminalHelper.banner
        puts "         #{Cable::Helpers::TerminalHelper.able_stamp}"
        puts "         v#{Cable::Base.version}"
        puts "\n"
      end
      
    end
  end
end