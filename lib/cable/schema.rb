module Cable
  #Influenced by devise's schema module. Methods defined here will be available within migartion files to apply a schema concept.
  
  module Schema
    
    # Provides a common set of address fields such as, street_address_1, street_address_2, city, state, zip_code and country as String fields.
    def addressable
      apply_cable_schema :street_address_1, String
      apply_cable_schema :street_address_2, String
      apply_cable_schema :city, String
      apply_cable_schema :state, String
      apply_cable_schema :zip_code, String
      apply_cable_schema :country, String
    end
    
    def nameable
      apply_cable_schema :first_name, String
      apply_cable_schema :middle_name, String
      apply_cable_schema :last_name, String
    end
    
    def contactable
      nameable
      apply_cable_schema :email_address, String
      apply_cable_schema :phone_number, String
    end
    
    # Provides a convenience method for all the needed fields used in Cable menus.
    def menuable
      apply_cable_schema :title, String
      apply_cable_schema :cable_menuable_id , Integer
      apply_cable_schema :cable_menuable_type, String
      apply_cable_schema :parent_id, Integer
      apply_cable_schema :lft, Integer
      apply_cable_schema :rgt, Integer
      apply_cable_schema :url, String
      apply_cable_schema :menu_identifier, String
      apply_cable_schema :show_in_menu, :boolean, :default => true
      apply_cable_schema :meta_description, String
      apply_cable_schema :meta_keywords, String
      apply_cable_schema :special_action, String
      apply_cable_schema :marketable_url, String
      apply_cable_schema :show_on_landing_page, :boolean
      apply_cable_schema :template, String
      apply_cable_schema :tree_id, Integer
    end
   # @note Overwrite with specific modification to create your own schema.
    def apply_cable_schema(name, type, options={})
      raise NotImplementedError
    end
  end
end

