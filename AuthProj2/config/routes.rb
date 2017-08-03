Rails.application.routes.draw do
  get 'secrets/index'

  # get 'sessions/new'
  #
  # get 'users/new'
  #
  # get 'users/show'
  #
  # get 'users/edit'

 resources :sessions,only: [:new, :create, :destroy]
 #resources :users,only: [:show, :new , :edit, :create, :update]

 resources :users

 resources :secrets

 post 'secrets/like' => "secrets#like" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# Prefix Verb   URI Pattern               Controller#Action
# sessions POST   /sessions(.:format)       sessions#create
# new_session GET    /sessions/new(.:format)   sessions#new
# session DELETE /sessions/:id(.:format)   sessions#destroy
#  users GET    /users(.:format)          users#index
#        POST   /users(.:format)          users#create
# new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#   user GET    /users/:id(.:format)      users#show
#        PATCH  /users/:id(.:format)      users#update
#        PUT    /users/:id(.:format)      users#update
#        DELETE /users/:id(.:format)      users#destroy
