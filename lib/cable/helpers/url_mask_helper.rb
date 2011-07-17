module Cable
  module Helpers
    module UrlMaskHelper
    
     def prepare_variables_for_masked_resources( masked_resources )
       masked_resources.collect{|d| d.maskable_type}.uniq.each do |i| 
         instance_variable_set("@#{i.tableize}_for_resource", masked_resources.collect{|r| r.resource if r.maskable_type == i}.compact)
       end
     end
     
     def prepare_resources_by_region( masked_resources )
       @_content_for_region = Hash.new
       masked_resources.collect{|d| d.region }.uniq.compact.collect do |region|
         @_content_for_region[region.to_sym] = masked_resources.select{|mask|  mask; mask.region == region}
       end
     end
     
     def content_for_region?(region)
       return false if @_content_for_region.nil? || !@_content_for_region.has_key?(region.to_sym)
       true
     end

     def content_for_region(region)
       if content_for_region?(region)
         self.send("content_for_#{region.to_s}", @_content_for_region[region] ) if self.respond_to?("content_for_#{region.to_s}".to_sym)
       end
     end
     
    end
  end
end
