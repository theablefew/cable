class Cable::UrlMask < ActiveRecord::Base
  
  belongs_to :maskable, :polymorphic => true
  
  def find_resource_by_url( url )
    
  end
  
end