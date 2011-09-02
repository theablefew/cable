class CableSweeper < ActionController::Caching::Sweeper
  observe Location if defined?(Location)
  
  def after_save( record )
    puts "Expiring #{record.url}".color(:red)
    Cable::Caching::Cache.clear_cache_folder!
    expire_page( record.url )
  end
end
