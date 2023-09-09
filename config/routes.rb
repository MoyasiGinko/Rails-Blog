Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end

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
