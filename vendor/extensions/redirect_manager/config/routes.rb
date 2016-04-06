Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :redirects do
    resources :redirect_items, :only => [:index, :show]
  end

  # Admin routes
  namespace :redirects, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/redirects" do
      resources :redirect_items, :except => :show do
        collection do
          post :update_positions
        end
      end
    end


  end
end

