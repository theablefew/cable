class Location < Cable::Locations::Location
  acts_as_nested_set
  has_many :menus, :dependent => :destroy
  accepts_nested_attributes_for :menus, :reject_if => :check_menu_permission
end
