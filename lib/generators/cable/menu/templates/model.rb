class <%= class_name %> < Cable::Menu::Base
  acts_as_cable_menu
  prevent_deletion :home, :footer
end
