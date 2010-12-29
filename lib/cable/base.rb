require 'cable'

module Cable
  class Base
    # @@version
    
    def self.version
      @@version ||= self.get_version_number
    end
    
    protected
    
    def self.get_version_number
      dir = File.expand_path("../../../", __FILE__)
      File.read("#{dir}/VERSION")
    end
    
  end
end