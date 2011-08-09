class CreateCableCacheSettings < ActiveRecord::Migration
  def self.up
    create_table :cable_cache_settings do |t|
      t.boolean :enabled
      t.decimal :clear_interval_in_milliseconds
      t.timestamps
    end
    
  end

  def self.down
    drop_table :cable_cache
  end
end
