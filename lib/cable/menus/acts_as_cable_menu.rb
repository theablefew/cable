module Cable
  module Menus
    module ActsAsCableMenu
      def self.included( base )
        base.send :extend, ClassMethods
      end
  
      module ClassMethods
  
        def acts_as_cable_menu( reflection_options = {} )
          belongs_to :location#, reflection_options.merge( )
          attr_accessor :creatable

          send :include, InstanceMethods
          send :include, Cable::Menus::SimpleNavigationMethods

          # before_create :check_for_permission
          
          yields self if block_given?
          
        end
        
        def nested_set_hash(set) 
          stack = [] 
          result = []
          set.each do |node|
            if stack.empty?
              stack.push({:key => node.key, :url => node.url, :name => node.title, :node => node.location, :items => []})
              result << stack.last
              next
            end
            if stack.last[:node].lft < node.location.lft && node.location.lft < stack.last[:node].rgt
              child = {:key => node.key, :url => node.url, :name => node.title, :options => node.options, :node => node.location, :items => []}
              stack.last[:items] << child
              if node.location.rgt + 1 == stack.last[:node].rgt
                stack.pop 
              end
              unless node.location.leaf?
                stack.push(child)
              end
            else
              stack.pop
              stack.push({:key => node.key, :url => node.url, :name => node.title, :node => node.location, :items => []})
              result << stack.last 
              next
            end
          end
          result
        end
        
        def to_simple_nav( *menu_item )
           nested_set_hash( visible_menus( menu_item )  )
        end
        
        def visible_menus( *menu_item )
          self.includes(:location).where(:locations => {:tree_id => menu_item}, :show_in_menu => true).where( "locations.parent_id IS NOT NULL").order('locations.lft')
        end

        def by_url( location )
          location = location.root
          menu_tree = self.includes(:location).where(:locations => {:lft => location.lft...location.rgt}, :show_in_menu => true).where( "locations.parent_id IS NOT NULL and menus.show_in_menu = 1").order('locations.lft') 
          nested_set_hash( menu_tree )
        end
        
        def locations
          self.all.includes(:location).collect(&:location)
        end
        
        def roots
          Location.roots.includes(:menus).collect{|loc| loc.menus.first unless loc.menus.blank? }.flatten
        end
      end
  
      module InstanceMethods
        
        def resource
          self.location.resource
        end
        
        def resource=( args )
          resource_type, resource_id = args.scan(/(\w+)|\,\s(\d+)\]/).flatten.compact
          if Cable.resources.include?(resource_type)
            self.cable_menuable_id = resource_id
            self.cable_menuable_type = resource_type
          end
        end
        
        def self_and_siblings
          self.location.self_and_siblings
        end
        
        def children(options = nil)
          self.location.children.includes(:menus).collect{|m| m.menus.where(:show_in_menu => true)}.flatten
        end
        
        def route
          (self.ancestors.collect{|an| an.url } << self.url).join
        end
        
        def url
          self.location.url
        end
        
        def title
          if self[:title].blank?
            return "" if self.new_record?
            return self.resource.title unless self.resource.nil?
            return self.url
          else
            self[:title]
          end
          
        end
        
      end
    end
  end
end