Rails.application.routes.draw do
  # root to: 'contacts#index' 

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :users, only: [:index, :show, :update, :destroy]
  resources :contacts, except: [:new, :edit]

  resources :addresses, only: [] do
    collection do
      get :show, path: 'show/:cep', action: 'show'
    end
  end

end
