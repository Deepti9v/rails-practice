Rails.application.routes.draw do

# 
#   Prefix Verb   URI Pattern                                      Controller#Action
# students_index GET    /students/index(.:format)                        students#index
# students_new GET    /students/new(.:format)                          students#new
# students_create GET    /students/create(.:format)                       students#create
# students_edit GET    /students/edit(.:format)                         students#edit
# students_update GET    /students/update(.:format)                       students#update
# students_show GET    /students/show(.:format)                         students#show
# students_destroy GET    /students/destroy(.:format)                      students#destroy
#     root GET    /                                                branches#index
# branch_students GET    /branches/:branch_id/students(.:format)          students#index
#          POST   /branches/:branch_id/students(.:format)          students#create
# new_branch_student GET    /branches/:branch_id/students/new(.:format)      students#new
# edit_branch_student GET    /branches/:branch_id/students/:id/edit(.:format) students#edit
# branch_student GET    /branches/:branch_id/students/:id(.:format)      students#show
#          PATCH  /branches/:branch_id/students/:id(.:format)      students#update
#          PUT    /branches/:branch_id/students/:id(.:format)      students#update
#          DELETE /branches/:branch_id/students/:id(.:format)      students#destroy
# branches GET    /branches(.:format)                              branches#index
#          POST   /branches(.:format)                              branches#create
# new_branch GET    /branches/new(.:format)                          branches#new
# edit_branch GET    /branches/:id/edit(.:format)                     branches#edit
#   branch GET    /branches/:id(.:format)                          branches#show
#          PATCH  /branches/:id(.:format)                          branches#update
#          PUT    /branches/:id(.:format)                          branches#update
#          DELETE /branches/:id(.:format)                          branches#destroy



  root "branches#index"
  resources :branches do
    resources :students
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
