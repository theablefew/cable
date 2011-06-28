require 'rails'
require 'awesome_nested_set'

module Cable
  module Menu
    module ActsAsCableMenu
      def self.included( base )
        base.send :extend, ClassMethods
      end
  
      module ClassMethods
  
        def acts_as_cable_menu( reflection_options = {} )
          send :include, InstanceMethods
          belongs_to :location
          # belongs_to :cable_menuable, reflection_options.merge( :polymorphic => true )
          # accepts_nested_attributes_for :cable_menuable
          # acts_as_nested_set 
          # :scope => :tree_id
          
          yields self if block_given?
          
        end
      end
  
      module InstanceMethods
    
        def resource
          self.cable_menuable
        end
        
        def resource=( args )
          resource_type, resource_id = args.scan(/(\w+)|\,\s(\d+)\]/).flatten.compact
          if Cable.resources.include?(resource_type)
            self.cable_menuable_id = resource_id
            self.cable_menuable_type = resource_type
          end
        end
    
        def route
          (self.ancestors.collect{|an| an.url } << self.url).join
        end
    
      end
    end
  end
end