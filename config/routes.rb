Rails.application.routes.draw do
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
