Rails.application.routes.draw do
  # root to: 'contacts#index' 

  post '/login', to: 'users/sessions#create'
  delete '/logout', to: 'users/sessions#destroy'
  post '/password/forgot', to: 'users/passwords#forgot'
  post '/password/reset', to: 'users/passwords#reset'
  post '/signup', to: 'users/registrations#create'

  resources :users, only: [:index, :show, :update, :destroy]
  resources :contacts, except: [:new, :edit]

  resources :addresses, only: [] do
    collection do
      get :show, path: 'show/:cep', action: 'show'
    end
  end

end
