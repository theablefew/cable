module Schemata
  module Schema
    def menuable
      apply_schema :title, String
      apply_schema :menu_identifier, String
      apply_schema :show_in_menu, :boolean, :default => true
      apply_schema :meta_description, String
      apply_schema :meta_keywords, String
      apply_schema :special_action, String
      apply_schema :show_on_landing_page, :boolean
      apply_schema :template, String
      apply_schema :options, :text
      apply_schema :location_id, Integer
    end
  end
end