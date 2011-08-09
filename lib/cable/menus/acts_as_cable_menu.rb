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
        
        def arranged(*tree) 
          depth = 0
          arranged = {:items => []}
          stack = [arranged] #insertion_points          
          Location.includes(:menus).eager_load(:menus).where(:tree_id => tree , :menus => {:show_in_menu => true} ).order('lft').each_with_level do |node, level|
            next if level > depth && stack.last[:items].last && node.parent_id != stack.last[:items].last[:node].id
            stack.push(stack.last[:items].last) if level > depth
            (depth - level).times{ stack.pop }  if level < depth
            child = {:key => node.menus.first.key, :url => node.url, :name => node.menus.first.title, :options => node.menus.first.options, :node => node, :items => []}
            stack.last[:items] << child
            depth = level
          end
          arranged[:items].first[:items]
        end
        
        def to_simple_nav( *menu_item )
          Menu.arranged( menu_item )
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
