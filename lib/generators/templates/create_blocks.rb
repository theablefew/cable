class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.string :title
      t.text :body
      t.integer :position
      t.string :region
      t.integer :resource_id
      t.string :resource_type
      t.string :url
      t.string :link_title
      t.string :block_image_file_name
      t.string :block_image_content_type
      t.integer :block_image_file_size
      t.datetime :block_image_updated_at
      t.string :sub_head

      t.timestamps
      
    end
    
  end

  def self.down
    drop_table :blocks
  end
end
