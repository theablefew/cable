require 'rails'
require 'cable/acts_as_cable'
require 'cable/menu/acts_as_cable_menu'

module Cable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActiveRecord::Base.send(:include, Cable::ActsAsCable)
    end
  end
end

module Cable
  module Menu
    class Railtie < Rails::Railtie
      config.to_prepare do
        ActiveRecord::Base.send(:include, Cable::Menu::ActsAsCableMenu)
      end
    end
  end
end