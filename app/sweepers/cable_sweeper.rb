class CableSweeper < ActionController::Caching::Sweeper
  observe Location
  
  def after_save( record )
    expire_page( record.url )
  end
end