module Cable
  module Menu
    module SimpleNavigationMethods
    
    def self.included( base )
      # base.extend( ClassMethods )
      send :include, InstanceMethods 
    end
    
    module ClassMethods
      
    end
    
    module InstanceMethods
      def items
        self.children.all(:conditions => {:show_in_menu => true})
      end

      def key
        self.title.underscore.gsub(" ", "_").gsub("'","")
      end

      def name
        self.title
      end
    end
  end
end
end