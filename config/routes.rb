Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  

  get 'likes/create'
  root "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

end
