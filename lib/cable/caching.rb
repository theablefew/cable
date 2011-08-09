module Cable
  #Cable makes a few assumptions about caching. Cache should live in public/cache ( cable already configures this ), and your webserver should 
  #take care of serving those pages.
  #
  #
  #An apache vhost may look like this then:
  # 
  #
  #
  # RewriteCond %{REQUEST_URI} ^([^.]+)/$
  # RewriteRule ^[^.]+/$ /%1 [QSA,L]
  # 
  # RewriteCond %{THE_REQUEST} ^(GET|HEAD)
  # RewriteCond %{REQUEST_URI} ^([^.]+)$
  #
  # RewriteCond %{DOCUMENT_ROOT}/cache/%1.html -f
  # RewriteRule ^[^.]+$ /cache/%1.html [QSA,L]
  # 
  # RewriteCond %{THE_REQUEST} ^(GET|HEAD)
  # RewriteCond %{DOCUMENT_ROOT}/cache/index.html -f
  # RewriteRule ^$ /cache/index.html [QSA,L]
  # 
  module Caching
    def self.enabled?
      Cable::Caching::Cache.enabled?
    end
    
    def self.enable
      Cable::Caching::Cache.enabled = true
    end
    
    def self.disable
      Cable::Caching::Cache.enabled = false
    end
    
  end
end