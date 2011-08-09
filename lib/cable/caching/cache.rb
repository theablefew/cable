class Cable::Caching::Cache < ActiveRecord::Base
  
  set_table_name "cable_cache_settings"
  
  def self.cached
    self.cached_files.collect do |path|
      cached_page = Cable::Caching::CachedPage.new( path )
    end.select do |cached_page|
      cached_page.valid?
    end
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
    instance.update_attributes(:enabled =>  bool)
  end
    
  def self.clear_interval_in_milliseconds
    instance.clear_interval_in_milliseconds
  end
  
  def self.flush
    Location.all.each do |loc|
      expire_page( loc.url )
    end
  end
  
  def self.instance
    self.create( :enabled => false ) if self.first.nil? 
    self.first
  end
  
  private
  
  def self.cached_files
    FileList["#{ActionController::Base.page_cache_directory}/**/*.html"]
  end
  
end