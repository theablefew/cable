module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/base'
  
  puts "Initializing Cable #{Cable::Base.version}"
  
  
end