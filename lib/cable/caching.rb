module Cable
  module Caching
    def self.enabled?
      Cable::Caching::Cache.enabled?
    end
    
    def self.enable
      Cable::Caching::Cache.enabled = true
    end
  end
end