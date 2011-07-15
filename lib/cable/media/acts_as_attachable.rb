# require 'rails'
module Cable
  module Media
    module ActsAsAttachable
      def self.included( base )
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def has_attachments(*args)
          send :include, InstanceMethods
          add_collections(args)
        end

        def add_collections(assets)
          all = (assets.size == 1 and assets.first == :all)
          if not all and assets.is_a?(Array)
            assets.each{|a| add_asset(a)}
          else
            if defined?(Rails.root)
              (
                Dir["#{Rails.root}/app/models/*"] + 
                Dir["#{Rails.root}/vendor/plugins/acts_as_attachable/app/models/*"]
              ).each do |e|
                  e = File.basename(e)
                  if File.extname(e) == '.rb' and e.split('_').first == 'attachable'
                     add_asset(e.split('.').first)
                  end
              end
            end 
          end
        end

        def add_asset(asset)
          has_many(asset.pluralize.to_sym, :as => :attachable)
        end
      end

      module InstanceMethods
      end
      
    end
  end
end