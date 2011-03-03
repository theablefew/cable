require 'orm_adapter/adapters/active_record'
module Cable
  module Orm
    # This module contains some helpers and handle schema (migrations):
    #
    #   create_table :accounts do |t|
    #     t.menuable
    #     t.nameable
    #     t.addressable
    #     t.contactable
    #     t.timestamps
    #   end
    #
    #   
    module ActiveRecord
      module Schema
        include Cable::Schema

        # Tell how to apply schema methods.
        def apply_cable_schema(name, type, options={})
          column name, type.to_s.downcase.to_sym, options
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, Cable::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Cable::Orm::ActiveRecord::Schema