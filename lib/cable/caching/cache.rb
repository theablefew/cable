class Cable::Caching::Cache < ActiveRecord::Base
  
  self.table_name "cable_cache_settings"
  
  def self.cached
    self.cached_files.collect do |path|
      cached_page = Cable::Caching::CachedPage.new( path )
    end.select do |cached_page|
      cached_page.valid?
    end
  end

  def self.clear_cache_folder!
    logger.info "Clearing #{ActionController::Base.page_cache_directory}!".color(:red)
    if self.enabled? and File.exists?(ActionController::Base.page_cache_directory)
      FileUtils.remove_dir("#{ActionController::Base.page_cache_directory}") 
    end
  end

  def self.enabled?
    instance.enabled?
  end
  
  def self.enabled
    instance.enabled
  end
  
  def self.enabled=( bool )
    instance.update_attributes(:enabled =>  bool)
    ActionController::Base.perform_caching = bool
    FileUtils.touch("#{Rails.root}/tmp/restart.txt") unless Rails.env.development?
  end
    
  def self.clear_interval_in_milliseconds
    instance.clear_interval_in_milliseconds
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