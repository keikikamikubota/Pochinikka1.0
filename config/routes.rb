Rails.application.routes.draw do
  root 'users#index'
  get 'sessions/new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :admins, only: [:new, :create, :show, :edit, :update]
  # user複数をまとめて登録するのでmemberではなくcollection
  resources :users do
    collection do
      post :export_to_google_sheets
    end
  end
  resources :sheets do
    member do
      post :import_exec
    end
    collection do
      get :fetch_spreadsheet_data
    end
  end
  resources :import_details
end
