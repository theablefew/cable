require 'rails'
require 'active_record'
require 'action_view'
module Cable
    module ActsAsCable
      def self.included( base )
        base.send :extend, ClassMethods

      end

      module ClassMethods
        
        def acts_as_cable( reflection_options = {} )
          send :include, InstanceMethods
          send :include, ActionView::Helpers::TextHelper
          
          with_modules = []
          with_modules << reflection_options.delete(:with) if reflection_options.has_key?(:with)
          with_modules.flatten!
          
          has_one :location, reflection_options.merge( :as => :locatable )
          has_many :blocks, :as => :resource if with_modules.include? :blocks
          accepts_nested_attributes_for :location
          
          self.cattr_accessor :default_template
          self.default_template = "default"
          
          yield self if block_given?
        end
        
        def template( template_name )
          self.default_template = (Cable.templates.include?( template_name.to_s )) ? template_name.to_s : :default.to_s
        end
        
      end
      
      module InstanceMethods
        
        def to_json_for_autocomplete
          displayable_string = first_displayable_attribute
          #TODO: find first string attr or look at sphinx index# if displayable_string.nil?
          { :label => "#{truncate(displayable_string, :length => 34)}" , :value => "#{(displayable_string)}", :type => self.class.name  }
        end
    
        def first_displayable_attribute
          displayable_attr = [ :title, :name, :first_name, :email, :email_address ].select{|attr| self.respond_to? attr }.first
          displayable_string = (displayable_attr.nil?) ? "Title not available" : self[displayable_attr]
        end
    
      end
      
    end
end
