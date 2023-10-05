Rails.application.routes.draw do
  resources :users
  resources :sheets
  resources :import_details
end
