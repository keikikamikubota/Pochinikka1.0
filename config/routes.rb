Rails.application.routes.draw do
  get 'sessions/new'
  root 'users#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :admins, only: [:new, :create, :show, :edit, :update]
  #user複数をまとめて登録するのでmemberではなくcollection
  resources :users do
    collection do
      post :export_to_google_sheets
    end
  end
  resources :sheets do
    member do
      post :import_exec
    end
  end
  resources :import_details
end
