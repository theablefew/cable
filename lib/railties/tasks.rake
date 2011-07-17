require 'cable'

desc "Shows Cable Version"
namespace :cable do
  task :version do
    puts Cable::Helpers::TerminalHelper.version
  end
end