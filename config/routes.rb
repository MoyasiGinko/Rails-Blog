Rails.application.routes.draw do
  get 'likes/create'
  root "users#index"
  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create, :destroy]
    end
  end
end
