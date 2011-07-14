module Cable
  module Menus
    module SimpleNavigationMethods
      
      
      def items
        # self.children.where(:show_in_menu => true)
        self.children
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
      
      def items_hash
        
        # items = []
        #         parents = Location.roots[1].descendants.includes(:menus).reorder("parent_id ASC ").group_by{|o| o.parent_id}
        #         parent.to_a
        #         Location.each_with_level(Location.where(:id => 10).first.self_and_descendants.includes(:menus)) do |loc, level| 
        #           puts 
        #           # {:key => loc.menu.key, :name => loc.menu.name, :url => loc.url, :options => loc.menu.options, :items => [
        #           #           
        #           #         ]
        #         end
      end

      
    end
  end
end