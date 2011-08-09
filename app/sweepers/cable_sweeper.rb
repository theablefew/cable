class CableSweeper < ActionController::Caching::Sweeper
  observe Location
  
  def after_save( record )
    puts "Clearing cache for #{record.url[0..-1]}"
    expire_page( record.url )
  end
end