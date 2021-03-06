# require 'rails'
require 'active_record'
require 'action_view'
module Cable
    module ActsAsMaskable
      def self.included( base )
        base.send :extend, ClassMethods

      end

      module ClassMethods
        
        def acts_as_maskable( reflection_options = {} )
          has_many :url_masks, :as => :maskable, :dependent => :destroy
          send :include, InstanceMethods
          send :include, ActionView::Helpers::TextHelper
          validates_associated :url_masks, :message => "are invalid"
          
          accepts_nested_attributes_for :url_masks, :allow_destroy => true
          
          yield self if block_given?
        end
        
        
      end
      
      module InstanceMethods
        
      end
      
    end
end
