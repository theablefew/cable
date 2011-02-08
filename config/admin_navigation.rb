SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |admin|
    admin.item :admin, "Home", '/admin'
    admin.item :admin, "Menu", "/admin/menus" do |menus|
      if Cable.class_exists? "Menu"
        Menu.roots.each do |tree|
          menus.item :edit, tree.title, "/admin/menus/show/#{tree.id}"
        end
        menus.item :new, "New Menu Item", new_admin_menu_path
      end
    end
    
    admin.item :global_setting, 'Global Settings', admin_cable_settings_path do |global_settings|
      global_settings.item :edit, "Edit Global Settings", edit_admin_cable_setting_path( Cable::Setting.last )
    end
    
  end
end