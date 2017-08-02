FactoryGirl.define do
  factory :user do
    name "Deepti"
    email "deepti8v@gmail.com" #This needs to be different than whats in the test DB. Else ur unique contraint will fail
    password "password"
    password_confirmation "password"
  end
end
