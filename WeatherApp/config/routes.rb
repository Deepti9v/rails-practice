Rails.application.routes.draw do
  resources :locations
  get 'weather/index'
  post 'weather/find'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
