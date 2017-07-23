Rails.application.routes.draw do

  post 'profile/create' => 'profile#create'
  get 'profile/new'
  get 'profile/edit'
  get 'profile/update'
  get 'profile/show' => 'profile#show'
  get 'profile/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
