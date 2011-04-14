module Schemata
  module Schema
    def menuable
      apply_schema :title, String
      apply_schema :cable_menuable_id , Integer
      apply_schema :cable_menuable_type, String
      apply_schema :parent_id, Integer
      apply_schema :lft, Integer
      apply_schema :rgt, Integer
      apply_schema :url, String
      apply_schema :menu_identifier, String
      apply_schema :show_in_menu, :boolean, :default => true
      apply_schema :meta_description, String
      apply_schema :meta_keywords, String
      apply_schema :special_action, String
      apply_schema :marketable_url, String
      apply_schema :show_on_landing_page, :boolean
      apply_schema :template, String
      apply_schema :tree_id, Integer
      apply_schema :options, :text
    end
  end
end