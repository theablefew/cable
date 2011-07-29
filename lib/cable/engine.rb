require 'rails'
require 'cable'
require 'cocoon'
require 'nested_set'
require 'kaminari'
require 'formtastic'
require 'seedbed'
require 'tiny_mce'
require 'jquery-rails'
require 'rainbow'
require 'thinking_sphinx'
require 'simple-navigation'
require 'wirble'
require 'annotate'

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