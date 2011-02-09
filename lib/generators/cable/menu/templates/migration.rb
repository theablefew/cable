class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string :title
      t.integer :cable_menuable_id
      t.string :cable_menuable_type
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :url
      t.string :menu_identifier
      t.boolean :show_in_menu, :default => true
      t.string :meta_description
      t.string :meta_keywords
      t.string :special_action
      t.string :marketable_url
      t.boolean :show_on_landing_page
      t.string :template
      t.string :special_action
      t.integer :tree_id
      
<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps
    end

    # add_index :<%= table_name %>, :lft
    # add_index :<%= table_name %>, :rgt
    # add_index :<%= table_name %>, :parent_id
    # add_index :<%= table_name %>, :url

  end

  def self.down
    drop_table :<%= table_name %>
  end
end