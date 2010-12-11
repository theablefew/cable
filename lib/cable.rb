module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/railtie'
  
  autoload :ActsAsCable, 'cable/acts_as_cable'
  autoload :Base, 'cable/base'
  autoload :Menu, 'cable/menu'
  autoload :Page, 'cable/page'
  autoload :Setting, 'cable/setting'
  autoload :CableControllerHelpers, 'cable/controllers/cable_controller_helpers'
  autoload :Block, 'cable/block'
  
  module Menu
    autoload :ActsAsCableMenu, "cable/menu/acts_as_cable_menu"
    autoload :SimpleNavigationMethods, "cable/menu/simple_navigation_methods"
    autoload :UrlHelper, 'cable/menu/url_helper'
    autoload :Base, "cable/menu/base"
  end
  
  module Media
    autoload :ActsAsAttachable, "cable/media/acts_as_attachable"
    autoload :Asset, "cable/media/asset"
  end
  
  mattr_accessor :regions
  @@regions = []
  
  mattr_accessor :templates
  @@templates = ["default"]
  
  mattr_accessor :special_actions
  @@special_actions = []
  
  def self.setup
     yield self
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