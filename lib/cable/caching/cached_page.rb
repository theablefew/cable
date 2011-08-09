class Cable::Caching::CachedPage
  
  attr_reader :location, :timestamp, :path
  
  def initialize(path_to_page)
    @path = path_to_page
    @location = Location.find_by_path( path.gsub("#{ActionController::Base.page_cache_directory}/",'').gsub('.html','') )
    @timestamp = File.mtime( path )
  end
  
  def valid?
    return !self.location.nil?
  end
  
  def delete!
    expire_page( :controller => "/main", :action => "find_by_url", :url => location.url )
  end
  

  
  private
  
end