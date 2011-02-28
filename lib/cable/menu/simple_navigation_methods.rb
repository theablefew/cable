module Cable
  module Menu
    module SimpleNavigationMethods
      attr_accessor :options
      
      def items
        self.children.where(:show_in_menu => true)
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