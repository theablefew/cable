module Cable
  #Influenced by devise's schema module. 
  module Schema
    
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
      apply_cable_schema :last_name, String
    end
    
    def contactable
      nameable
      apply_cable_schema :email_address, String
      apply_cable_schema :phone_number, String
    end
    
    def menuable
      apply_cable_schema :title, String
      apply_cable_schema :cable_menuable_id , Integer
      apply_cable_schema :cable_menuable_type, String
      apply_cable_schema :parent_id, Integer
      apply_cable_schema :lft, Integer
      apply_cable_schema :rgt, Integer
      apply_cable_schema :url, String
      apply_cable_schema :menu_identifier, String
      apply_cable_schema :show_in_menu, Boolean, :default => true
      apply_cable_schema :meta_description, String
      apply_cable_schema :meta_keywords, String
      apply_cable_schema :special_action, String
      apply_cable_schema :marketable_url, String
      apply_cable_schema :show_on_landing_page, Boolean
      apply_cable_schema :template, String
      apply_cable_schema :tree_id, Integer
    end
   # Overwrite with specific modification to create your own schema.
    def apply_cable_schema(name, type, options={})
      raise NotImplementedError
    end
  end
  
end