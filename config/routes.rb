Rails.application.routes.draw do
  resources :maps, only: [:index, :new, :create, :show]
  root 'maps#index'
end
