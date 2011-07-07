module Schemata
  module Schema
    def maskable
      
      apply_schema :maskable_id, Integer
      apply_schema :maskable_type, String
      apply_schema :url_mask, String

    end
  end
end