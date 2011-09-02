#config/routes.rb
# puts Cable::Engine.config.inspect
# Cable::Engine.routes.draw do
  # match '/admin(/:action(/:id))' => 'admin'
# end
Rails.application.routes.draw do
  

  namespace :admin do 
    resources :search, :only => [:index], :as => 'search'
    resources :locations

    
    resources :cache, :only => [:index] do
      collection do 
        get :disable_cache
        get :enable_cache
        post :flush_all
      end
        
  
      member do 
        get :refresh_cached_page
        get :remove_cached_page
      end
    end

  end

  
  
  
  match '/admin' => 'admin#index'
  match '/admin(/:action(/:id))' => 'admin'
  match '*url' => 'main#find_by_url'
end
