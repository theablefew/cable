require 'cable'
require 'rails'

module Cable
  class Engine < Rails::Engine
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
      app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
    end
    
    rake_tasks do
       load "railties/tasks.rake"
    end
  end
end