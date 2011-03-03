module Cable
  module Menu
    module SimpleNavigationMethods
      
      def items
        self.children.where(:show_in_menu => true)
      end

      def key
        self.title.underscore.gsub(" ", "_").gsub("'","")
      end

      def name
        self.title
      end
      
      def options
        return Hash.new if self[:options].nil?
        self[:options]
      end
      
    end
  end
end