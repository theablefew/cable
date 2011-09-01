require 'rails'
require 'orm_adapter'
require 'schemata'


#Cable can serve its own static assets and files, but to do this in production you must configure your webserver
# 
#Apache vhost might include this then:
#
# #If exists in rails app skip rewrite
# RewriteCond /home/deploy/peabody.theablefew.com/current/public%{REQUEST_URI} -f [OR]
# RewriteCond /home/deploy/peabody.theablefew.com/current/public%{REQUEST_URI} -d
# RewriteRule (.*) - [S=2]
# #if it doesn't server cable asset instead
# RewriteCond /home/deploy/peabody.theablefew.com/shared/cable/public%{REQUEST_URI} -f [OR]
# RewriteCond /home/deploy/peabody.theablefew.com/shared/cable/public%{REQUEST_URI} -d
# RewriteRule ^ /home/deploy/peabody.theablefew.com/shared/cable/public%{REQUEST_URI} [L]
#

module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/railtie'

  autoload :Base, 'cable/base'
  autoload :ActsAsCable, 'cable/acts_as_cable'
  autoload :ActsAsMaskable, 'cable/acts_as_maskable'
  autoload :Resource, 'cable/resource'
  autoload :Setting, 'cable/setting'
  autoload :CableControllerHelpers, 'cable/controllers/cable_controller_helpers'
  autoload :Block, 'cable/block'
  autoload :SpecialAction, 'cable/special_action'
  autoload :UrlMask, 'cable/url_mask'
  autoload :Caching, 'cable/caching'
  
  module Locations
    autoload :Location, 'cable/locations/location'
  end

  module Schema
    require 'cable/schema/menuable'
    require 'cable/schema/resourceable'
    require 'cable/schema/maskable'
  end
  
  module Errors
    autoload :ResourceAssociationError, "cable/errors/resource_association_error"
    autoload :SearchError, 'cable/errors/search_error'
    autoload :MissingInterfaceMethod, 'cable/errors/search_error'
  end
  
  module Menus
    autoload :ActsAsCableMenu, "cable/menus/acts_as_cable_menu"
    autoload :SimpleNavigationMethods, "cable/menus/simple_navigation_methods"
    autoload :Menu, "cable/menus/menu"
  end

  module Helpers
    autoload :UrlHelper, 'cable/helpers/url_helper'
    autoload :NestedSetHelper, 'cable/helpers/nested_set_helper'
    autoload :CableControllerHelpers, 'cable/helpers/cable_controller_helpers'
    autoload :KaminariHelper, 'cable/helpers/kaminari_helper'
    autoload :UrlMaskHelper, 'cable/helpers/url_mask_helper'
    autoload :TerminalHelper, 'cable/helpers/terminal_helper'
  end
  
  module Caching
    autoload :Cache, 'cable/caching/cache'
    autoload :CachedPage, 'cable/caching/cached_page'
  end
  
  mattr_accessor :regions
  @@regions = []
  
  mattr_accessor :templates
  # Used to store template files you wish to be available for rendering. All ERB templates are automatically loaded from {Cable::@@template_path}.
  @@templates = ["default"]
  
  mattr_accessor :special_actions
  @@special_actions = []
  
  mattr_accessor :template_path
  @@template_path = "main/templates"

  mattr_accessor :resources
  # Used to store a list of resources that you wish to be associated with menus.
  @@resources = []

  
  def self.setup
     yield self
     get_templates
  end
  
  # Checks {Cable::@@resources} and returns only the resources that are actually defined.
  def self.available_resources
     rsrc = Cable.resources.collect do |r| 
       r.classify.constantize.all if Cable.class_exists?( r )
     end
     rsrc.flatten
  end
  
  def self.resource_types
    rsrc = Cable.resources.collect do |r|
      r.classify.constantize if Cable.class_exists?( r )
    end
    rsrc.flatten
  end
  
  def self.class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
  
  protected
  
  def self.get_templates
    @@templates = Dir.glob(Rails.root + "app/views/#{@@template_path}/_*.erb").collect{|f| f.split("/").last.split(/_([\w\d-]+)[\.]/).second }
  end
  # puts "Initializing Cable #{Cable::Base.version}"
  # 
  # def self.add_mapping(resource, options)
  #   mapping = Devise::Mapping.new(resource, options)
  #   @@mappings[mapping.name] = mapping
  #   @@default_scope ||= mapping.name
  #   @@helpers.each { |h| h.define_helpers(mapping) }
  #   mapping
  # end
  
end

require 'cable/rails/routes'
# require 'cable/orm/active_record'