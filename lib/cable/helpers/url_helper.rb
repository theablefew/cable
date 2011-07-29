module Cable
  module Helpers
    module UrlHelper
      
      def external_link?
        return false if self[:url].nil?
        !self[:url].match( /^\w+:\/\// ).nil?
      end

      def direct_link?
        return false if self[:url].nil?
        !self[:url].match( /^\/\w/ ).nil?
      end
      
    end
  end
end
