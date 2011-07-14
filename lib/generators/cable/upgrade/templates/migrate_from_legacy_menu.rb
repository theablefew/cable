class MigrateFromLegacyMenu < ActiveRecord::Migration
  def self.up
    
    remove_column :menus, :cable_menuable_id
    remove_column :menus, :cable_menuable_type
    remove_column :menus, :parent_id
    remove_column :menus, :tree_id
    remove_column :menus, :lft
    remove_column :menus, :rgt
    remove_column :menus, :url
    remove_column :menus, :marketable_url
    remove_column :menus, :meta_description
    remove_column :menus, :meta_keywords
    remove_column :menus, :template
    remove_column :menus, :special_action

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end