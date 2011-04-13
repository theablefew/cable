require 'rails'
require 'cable/acts_as_cable'
require 'cable/menu/acts_as_cable_menu'
require 'cable/media/acts_as_attachable'
require 'schemata'

module Cable
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActiveRecord::Base.send(:include, Cable::ActsAsCable)
      ActiveRecord::ConnectionAdapters::Table.send :include, Schemata::Orm::ActiveRecord::Schema
      ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Schemata::Orm::ActiveRecord::Schema
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

module Cable
  module Media
    class Railtie < Rails::Railtie
      config.to_prepare do 
        ActiveRecord::Base.send(:include, Cable::Media::ActsAsAttachable)
      end
    end
  end
end