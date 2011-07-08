require 'rails'
require 'awesome_nested_set'
require 'rainbow'

module Cable
  module Menus
    module ActsAsCableMenu
      def self.included( base )
        base.send :extend, ClassMethods
      end
  
      module ClassMethods
  
        def acts_as_cable_menu( reflection_options = {} )
          belongs_to :location#, reflection_options.merge( )
          attr_accessor :creatable

          send :include, InstanceMethods

          # before_create :check_for_permission
          
          yields self if block_given?
          
        end
        
        def locations
          self.all.collect(&:location)
        end
        
        def roots
          Location.roots.collect{|loc| loc.menus.first unless loc.menus.blank? }.flatten
        end
      end
  
      module InstanceMethods
        
        def resource
          self.location.resource
        end
        
        def resource=( args )
          resource_type, resource_id = args.scan(/(\w+)|\,\s(\d+)\]/).flatten.compact
          if Cable.resources.include?(resource_type)
            self.cable_menuable_id = resource_id
            self.cable_menuable_type = resource_type
          end
        end
        
        def self_and_siblings
          self.location.self_and_siblings
        end
        
        def children
          self.location.children.reject{|loc| loc.menus.blank? }.flatten.collect{|men| men.menus.first}
        end
    
        def route
          (self.ancestors.collect{|an| an.url } << self.url).join
        end
        
        def url
          self.location.url
        end
        
        def title
          if self[:title].blank?
            self.resource.title unless self.new_record?
          else
            self[:title]
          end
          
        end
        
      end
    end
  end
end