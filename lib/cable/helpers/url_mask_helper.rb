module Cable
  module Helpers
    module UrlMaskHelper
      
     def prepare_variables_for_masked_resources( masked_resources )
       masked_resources.collect{|d| d.maskable_type}.uniq.each do |i| 
         instance_variable_set("@#{i.tableize}_for_resource", masked_resources.collect{|r| r.resource if r.maskable_type == i}.compact)
       end
     end

    end
  end
end
