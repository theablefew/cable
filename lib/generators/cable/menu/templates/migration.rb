class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.menuable
      
<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps
    end

    # add_index :<%= table_name %>, :lft
    # add_index :<%= table_name %>, :rgt
    # add_index :<%= table_name %>, :parent_id
    add_index :<%= table_name %>, :url
    # add_index :<%= table_name %>, :cable_menuable_id

  end

  def self.down
    drop_table :<%= table_name %>
  end
end