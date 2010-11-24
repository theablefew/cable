module Cable
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end