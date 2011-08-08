class Cable::Caching::Cache < ActiveRecord::Base
  
  set_table_name "cable_cache_settings"
  
  
  cattr_accessor :prevent_from_treating_as_cache
  @@prevent_from_treating_as_cache = [
                                     'public/404.html',
                                     'public/500.html',
                                     'public/422.html',
                                     'public/favicon.ico',
                                     'public/javascripts',
                                     'public/stylesheets',
                                     'public/assets', 
                                     'public/images',
                                     'public/robots.txt', 
                                     'public/maintenance.html', 
                                     'public/system',
                                     'public/fonts'
                                     ]

  def self.cached
    Dir['public/**'] - self.prevent_from_treating_as_cache
  end
  
  def self.create_cache_folder
    
  end
  
  def self.enabled?
    instance.enabled?
  end
  
  def self.enabled
    instance.enabled
  end
  
  def self.enabled=( bool )
    instance.enabled = bool
    instance.save
  end
    
  def self.clear_interval_in_milliseconds
    instance.clear_interval_in_milliseconds
  end
  
  def self.instance
    self.create( :enabled => false ) if self.first.nil? 
    self.first
  end
  
end