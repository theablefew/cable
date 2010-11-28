module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/railtie'
  require 'cable/acts_as_cable'
  require 'cable/base'  
  require 'cable/menu'
  require 'cable/page'
  # puts "Initializing Cable #{Cable::Base.version}"
  
end