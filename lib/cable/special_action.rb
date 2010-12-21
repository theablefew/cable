module Cable
  class SpecialAction
    
    attr_accessor :action
    attr_accessor :controller
    attr_accessor :name
    
    def initialize( name , hash = {} )
      self.name = name
      self.controller = hash[:controller] if hash.has_key? :controller
      self.action = hash[:action] if hash.has_key? :action
    end
    
    def path
      { :controller => self.controller , :action => self.action }
    end
    
  end
end