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
      t.boolean :show_in_menu
      t.string :meta_description
      t.string :meta_keywords
      t.string :special_action

<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps
    end

    add_index :<%= table_name %>, :lft,                :unique => true
    add_index :<%= table_name %>, :rgt,                :unique => true
    add_index :<%= table_name %>, :parent_id,          :unique => true
    add_index :<%= table_name %>, :url,                :unique => true

  end

  def self.down
    drop_table :<%= table_name %>
  end
end