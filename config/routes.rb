Rails.application.routes.draw do
  # root to: 'contacts#index' 

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :users, only: [:index, :show, :update, :destroy]
  # resources :contacts, except: [:new, :edit]
end
