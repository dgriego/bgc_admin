Rails.application.routes.draw do
  get '/users/sign_up', to: 'trips#index'
  devise_for :users, path_names: {sign_in: 'login',
                                  sign_out: 'logout'}

  authenticate :user do
    root to: 'trips#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users do
      collection { post :import }
      collection { delete :destroy_all_guardians }
    end

    resources :participants, only: [:index] do
      collection { post :import }
    end

    delete '/destroy_all_participants',
      to: 'participants#destroy_all_participants'

    resources :trips
  end
end
