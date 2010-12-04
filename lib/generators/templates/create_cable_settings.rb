class CreateCableSettings < ActiveRecord::Migration
  def self.up
    create_table :cable_settings do |t|
      t.string :site_title
      t.text :keywords
      t.string :analytics
      t.text :closure
      t.text :description
      t.string :contact_email
      t.text :footer_block_1
      t.text :footer_block_2
      t.string :copyright
      t.text :legal

      t.timestamps
      
    end
    Cable::Setting.create(:site_title => Rails.application.class.parent.name.underscore.titleize )
    
  end

  def self.down
    drop_table :cable_settings
  end
end
