Rails.application.routes.draw do
  root "pages#index"
  get 'pages/create_claim'

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create]
  resources :claims, only: [:index, :new, :create, :show] do
    put 'approve', on: :member
    put 'decline', on: :member
  end

end
