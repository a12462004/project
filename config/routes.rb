Rails.application.routes.draw do
  root 'weather#index'
  get "/weather", to:"weather#index"
  resources :states
  resources :weathers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
