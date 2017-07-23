Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "game/index" => "game#index"
  post "game/process_points" => "game#process_points"
end
