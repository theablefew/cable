SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |admin|
    admin.item :admin, "Home", '/admin'
    admin.item :global_setting, 'Global Settings', admin_cable_settings_path do |global_settings|
      global_settings.item :edit, "Edit Global Settings", edit_admin_cable_setting_path( Cable::Setting.last )
    end
  end
end