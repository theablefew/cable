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
          belongs_to :cable_menuable, reflection_options.merge( :polymorphic => true )
          
          acts_as_nested_set :scope => :tree_id
          
          yields self if block_given?
          
        end
      end
  
      module InstanceMethods
    
        def resource
          self.cable_menuable
        end
    
        def route
          (self.ancestors.collect{|an| an.url } << self.url).join
        end
    
      end
    end
  end
end