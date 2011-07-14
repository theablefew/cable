require 'rainbow'
class Cable::Menus::Menu < ActiveRecord::Base
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
  
    # validates_presence_of :title
    
    serialize :options
    
    scope :use_index, lambda {|index| 
      {:from => "#{quoted_table_name} USE INDEX(#{index})"}
    }
    
    include Cable::Helpers::UrlHelper  
    # Interface for nested_set
    
    def show_cb
      Menu.before_save_callback_chain
    end
    # @return [String]  The internally generated friendly URL or a custom url defined for this menu.
    
    # @return [String] The class of the associated resource as defined through cable_menuable polymorphic interface.
    def type
      # cable_menuable_type
    end
  
    def title_or_url
      # if self[:url].blank?
        self.title
      # else
        # self[:url]
      # end
    end
    
    def resource
      self.location.resource
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

