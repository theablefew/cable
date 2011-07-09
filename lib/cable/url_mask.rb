class Cable::UrlMask < ActiveRecord::Base
  
  belongs_to :maskable, :polymorphic => true
  
  def self.find_resource_by_url( request )
    parts = request.split('/')
    order = parts.to_enum(:each_with_index).collect{|part,index| parts.dup.slice(0..index).join("/") + "/*" }.flatten[1..-2].push( request )

    UrlMask.find_all_by_url_mask( order )
    # order.each do |part|
    #   maskable << UrlMask.find_all_by_url_mask( part )
    #   # return maskable unless maskable.empty?
    # end

  end
  
  def resource
    self.maskable
  end
  
end