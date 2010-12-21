require 'rails'
require 'active_record'

module Cable
    module ActsAsCable
      def self.included( base )
        base.send :extend, ClassMethods

      end

      module ClassMethods
        
        def acts_as_cable( reflection_options = {} )
          
          with_modules = []
          with_modules << reflection_options.delete(:with) if reflection_options.has_key?(:with)
          with_modules.flatten!
          
          has_one :menu, reflection_options.merge( :as => :cable_menuable )
          has_many :blocks, :as => :resource if with_modules.include? :blocks
          accepts_nested_attributes_for :menu
          
          self.cattr_accessor :default_template
          self.default_template = "default"
          
          yield self if block_given?
        end
        
        def template( template_name )
          self.default_template = (Cable.templates.include?( template_name.to_s )) ? template_name.to_s : :default.to_s
        end
        
      end
      
    end
end
