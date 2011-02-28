require 'rails'
require 'orm_adapter'

module Cable
  
  require 'cable/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'cable/railtie'
  
  autoload :Base, 'cable/base'
  autoload :ActsAsCable, 'cable/acts_as_cable'
  autoload :Menu, 'cable/menu'
  autoload :Page, 'cable/page'
  autoload :Setting, 'cable/setting'
  autoload :CableControllerHelpers, 'cable/controllers/cable_controller_helpers'
  autoload :Block, 'cable/block'
  autoload :SpecialAction, 'cable/special_action'
  autoload :Schema, 'cable/schema'
  
  module Errors
    autoload :ResourceAssociationError, "cable/errors/resource_association_error"
  end
  
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
require 'cable/orm/active_record'