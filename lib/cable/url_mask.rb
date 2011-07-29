class Cable::UrlMask < ActiveRecord::Base
  
  belongs_to :maskable, :polymorphic => true
  validates_presence_of :url_mask
  validates_presence_of :region
  
  def self.find_resource_by_url( request )
    parts = request.split('/')
    request = "/*" if request == "/"
    order = parts.to_enum(:each_with_index).collect{|part,index| parts.dup.slice(0..index).join("/") + "/*" }.flatten[0..-2].push( request )
    logger.info "Find Masks by: #{order}".color :yellow
    UrlMask.find_all_by_url_mask( order )
  end
  
  def resource
    self.maskable
  end
  
end