Rails.application.routes.draw do
  devise_for :users
  root to: 'trips#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection { post :import }
    collection { delete :destroy_all_guardians }
  end

  resources :trips, only: [:show]
end
