class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :locatable_id
      t.string :locatable_type
      t.integer :parent_id
      t.integer :tree_id
      t.integer :lft
      t.integer :rgt
      t.string :url
      t.string :marketable_url
      t.timestamps
    end
    
  end

  def self.down
    drop_table :locations
  end
end
