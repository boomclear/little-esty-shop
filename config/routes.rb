Rails.application.routes.draw do
  resources :merchants, only: [:show] do
    resources :coupons, only: [:index, :show, :new, :update]
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end

  post "/merchants/:merchant_id/coupons/new", to: "coupons#create"

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
