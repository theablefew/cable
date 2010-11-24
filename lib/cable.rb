module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/base'
  require "cable/cable_menu/acts_as_cable_menu"
  require "cable/cable_menu/acts_as_cable"
  
  puts "Initializing Cable #{Cable::Base.version}"
  
  
end