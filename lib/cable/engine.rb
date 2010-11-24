require 'cable'
require 'rails'

module Cable
  class Engine < Rails::Engine
    rake_tasks do
       load "railties/tasks.rake"
    end
  end
end