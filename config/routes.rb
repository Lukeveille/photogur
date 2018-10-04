Rails.application.routes.draw do
  root 'pictures#index'
  resources :pictures

  resource :users
  resource :session
end