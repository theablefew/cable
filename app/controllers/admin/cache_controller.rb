class Admin::CacheController < AdminController
  
  def index
    @cached_pages = Cable::Caching::Cache.cached
  end
  
  def remove_cached_page
    expire_page( Location.find_by_path( params[:id]).url )
  end
  
  def refresh_cached_page
    location = Location.find( params[:id]).url
    expire_page( location )
    Thread.new do 
      open("#{request.protocol}#{request.host_with_port}#{location}")
    end
    # cache_page( content, location.url )
    redirect_to( admin_cache_index_path , :notice => "Cleared cache for #{location}")
  end
  

  
  def flush_all
    Cable::Caching::Cache.flush
    redirect_to({ :controller => "admin/cache", :action => "index" }, :notice => "Flushed all cache ")  
  end
  
  def refresh_all
    
  end
  
  def disable_cache
    Cable::Caching.disable if Cable::Caching::Cache.enabled?
    Cable::Caching::Cache.flush
    render :nothing => true
  end
  
  def enable_cache
    Cable::Caching.enable 
    render :nothing => true
  end
  
end