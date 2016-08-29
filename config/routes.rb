Rails.application.routes.draw do
  resources :maps, only: [:index, :new, :create, :show]
  resources :about, only: [:index]
  root 'maps#index'
end
