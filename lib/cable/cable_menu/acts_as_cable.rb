require 'rails'

module Cable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActiveRecord::Base.send(:include, Cable::ActsAsCable)
    end
  end
end

module Cable::ActsAsCable
  def self.included( base )
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def acts_as_cable( reflection_options = {} )
      has_one :menu, reflection_options.merge( :as => :cable_menuable )
    end
  end
end
