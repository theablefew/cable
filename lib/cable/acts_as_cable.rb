require 'rails'
require 'active_record'

module Cable
    module ActsAsCable
      def self.included( base )
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_cable( reflection_options = {} )
          has_one :menu, reflection_options.merge( :as => :cable_menuable )
        end
      end
      
    end
end
