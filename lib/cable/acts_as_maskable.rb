require 'rails'
require 'active_record'
require 'action_view'
module Cable
    module ActsAsMaskable
      def self.included( base )
        base.send :extend, ClassMethods

      end

      module ClassMethods
        
        def acts_as_maskable( reflection_options = {} )
          has_many :masks, :as => :maskable, :dependent => :destroy
          send :include, InstanceMethods
          send :include, ActionView::Helpers::TextHelper
          
          accepts_nested_attributes_for :masks, :allow_destroy => true
          
          yield self if block_given?
        end
        
        
      end
      
      module InstanceMethods
        
      end
      
    end
end
