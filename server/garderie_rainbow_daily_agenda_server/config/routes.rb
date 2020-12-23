Rails.application.routes.draw do
  resources :child_reports
  
  root to: 'child_reports#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
