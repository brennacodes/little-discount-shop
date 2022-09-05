Rails.application.routes.draw do
  root 'sessions#new'
  
  get '/users/new', to: 'users#new', as: 'new_user'
  post '/users/new', to: 'users#create', as: 'create_user'

  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'new_login'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  post '/login', to: 'sessions#create', as: 'login'

  get "/merchants/:merchant_id/dashboard", to: "merchants#show", as: "merchant_dashboard"
  delete "/merchants/:merchant_id/discounts/:id", to: "merchant_discounts#destroy", as: "delete_merchant_discount"

  resources :merchants, only: [:index, :show] do
    resources :items, controller: 'merchant_items', except: [:destroy]
    resources :invoices, controller: 'merchant_invoices', only: [:index, :show, :edit, :update]
    resources :discounts, controller: 'merchant_discounts', except: [:destroy]
    resources :invoice_items, only: [:edit, :update]
  end
  
  get "/admin", to: "admin/dashboard#index", as: :admin_dashboard
  post "/admin/merchants/new", to: "admin/merchants#create"

  namespace :admin do
    resources :merchants
    resources :invoices
  end

  namespace :api do
    namespace :v1 do
      get "/", to: "home#index"
      
      namespace :items do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:item_id/merchant', controller: :merchants, action: :show, as: :merchant
      end
      
      resources :items
      
      namespace :merchants do
        get '/find', controller: :search, action: :show
        get '/find_all', controller: :search, action: :index
        get '/:merchant_id/items', controller: :items, action: :index, as: :items
      end
      
      resources :merchants, only: [:index, :show]
    end
  end
end