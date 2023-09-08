Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'likes/create'
  root "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create, :destroy]
    end
  end

end
