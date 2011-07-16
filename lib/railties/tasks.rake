require 'cable'

desc "Shows Cable Version"
namespace :cable do
  task :version do
    puts ""
    puts "Cable v#{Cable::Base.version}"
    puts "The Able Few | theablefew.com".color(:cyan)
    puts ""
  end
end