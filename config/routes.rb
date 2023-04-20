Rails.application.routes.draw do
  resources :users

  get 'import_export/index'
  post '/import_export/import', to: 'import_export#import'
  get 'import_export/export'

  root 'import_export#index'
end
