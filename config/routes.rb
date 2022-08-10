Rails.application.routes.draw do
  root 'admin/dashboard#index'
  
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
end