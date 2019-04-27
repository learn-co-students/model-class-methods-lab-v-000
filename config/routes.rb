Rails.application.routes.draw do
  resources :boats
  resources :captains
  resources :classifications
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
