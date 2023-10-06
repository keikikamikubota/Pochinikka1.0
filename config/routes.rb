Rails.application.routes.draw do
  resources :users
  resources :sheets do
    member do
      post :import_exec
    end
  end
  resources :import_details
end
