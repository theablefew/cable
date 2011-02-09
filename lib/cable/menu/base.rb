class Cable::Menu::Base < ActiveRecord::Base
    self.abstract_class = true
    class << self
      attr_accessor :non_deletable
    end
    
    # versioned
    # before_destroy :check_prevent_deletion
    # before_destroy :move_child_parent
    #all before destroy filters will not run after this line
    # acts_as_cable_menu
    # before_save :generate_marketable_url
    scope :top_nav, :conditions => {:title => "Top Navigation"}
    scope :footer_nav, :conditions => {:title => "Footer Navigation"}
  
    validates_presence_of :title
  
    include Cable::Menu::SimpleNavigationMethods
    include Cable::Menu::UrlHelper
    
    
    def left=(v)
      lft = v
    end
  
    def right=(v)
      rgt = v
    end
  
    def depth=(v)
    
    end
  
    def item_id=(v)
    end

    def show_cb
      Menu.before_save_callback_chain
    end

    def url
      return self[:url] if self.external_link? || self.direct_link?
      return "/#{self.marketable_url}"
    end
  
    def type
      cable_menuable_type
    end
    
    def reorder_children(ordered_ids)
      ordered_ids = ordered_ids.map(&:to_i)
      current_ids = children.map(&:id)
      unless current_ids - ordered_ids == [] && ordered_ids - current_ids == []
        raise ArgumentError, "Not ordering the same ids that I have as children. My children: #{current_ids.join(", ")}. Your list: #{ordered_ids.join(", ")}. Difference: #{(current_ids - ordered_ids).join(', ')} / #{(ordered_ids - current_ids).join(', ')}" 
      end
      j = 0
      transaction do
        for new_id in ordered_ids
          old_id = current_ids[j]
          if new_id == old_id
            j += 1
          else
            Menu.where(:id => new_id).first.move_to_left_of(old_id)
            current_ids.delete(new_id)
          end
        end
      end
    end
  
    def generate_marketable_url
      # puts "EXTERNAL LINK " if self.external_link?
      # puts "DIRECT LINK" if self.direct_link?
      
      unless self.external_link? 
        self.marketable_url = ((self.ancestors.sort_by{|anc| anc.level}.collect{ |a| a.title_or_url.parameterize.to_s } << self.title_or_url.parameterize.to_s))[1..-1].join("/") unless self.direct_link?
        puts "Generating marketable url: #{marketable_url}"
        puts "Children? #{self.class}"
        
        
        unless self.children.empty?
          self.children.each{|child| child.generate_marketable_url }
        end
      else
        self.marketable_url = ( self.direct_link? ) ? self[:url][1..-1] : self[:url]
      end
    
      self.save
    end
  
    def title_or_url
      if self[:url].blank?
        self.title
      else
        self[:url]
      end
    end
    
    def section_root
      self.ancestors[ self.level - (self.level - 1) ] || self.ancestors[0] || self
    end
    
    def differs?( pid , l , r )
      if self.parent.id != pid || self.lft != l || self.r != r
        # logger.info "DIFFERS"
        # logger.info "Parent ID: #{self.parent.id} - #{pid}" if self.parent.id != pid
        # logger.info "LEFT: #{self.lft} - #{l}" if self.lft != l
        # logger.info "RIGHT: #{self.rgt} - #{r}" if self.rgt != r
        return true 
      end
      return false
    end
    
    def self.prevent_deletion( *args )
      Menu.non_deletable = args
    end
    
    def self.get_routes
      Menu.all.collect( &:url )
    end
    
    private
  
    # Cancels the nested set :before_destroy callback by returning false.
    def move_child_parent
      pnode = self.root
      self.children.each do |child|
        # puts "Making #{child.title} child of #{pnode.title}."
        child.move_to_child_of( pnode.id )
      end
      self.delete
      false
    end
  
    def check_prevent_deletion
      return false if Menu.non_deletable.include?( self.title.downcase.to_sym )
      true
    end
end



# == Schema Information
#
# Table name: menus
#
#  id                   :integer(4)      not null, primary key
#  title                :string(255)
#  cable_menuable_id    :integer(4)
#  cable_menuable_type  :string(255)
#  parent_id            :integer(4)
#  lft                  :integer(4)
#  rgt                  :integer(4)
#  url                  :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  menu_identifier      :string(255)
#  template             :string(255)
#  show_in_menu         :boolean(1)      default(TRUE)
#  show_on_landing_page :boolean(1)      default(FALSE)
#  special_action       :string(255)
#  marketable_url       :string(255)
#  meta_description     :string(255)
#  meta_keywords        :string(255)
#

