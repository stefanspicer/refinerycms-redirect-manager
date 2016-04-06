Refinery::Core::Engine.routes.draw do
  # Admin routes
  namespace :redirects, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}" do
      resources :redirect_items, :path => "redirects", :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end
end

