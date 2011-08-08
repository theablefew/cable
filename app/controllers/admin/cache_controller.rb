class Admin::CacheController < AdminController
  
  def index
    Cable::Caching::Cache
  end
  
  def remove_cached_page
    
  end
  
  def refresh_cached_page
    
  end
  
  def refresh_all
    
  end
  
  def flush_all
    
  end
  
  def disable_cache
    if Cable::Caching::Cache.enabled? 
  end
  
  def enable_cache
    
  end
  
end