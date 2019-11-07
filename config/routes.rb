Rails.application.routes.draw do
  devise_for :users
  get "rides/:id/status", to: "rides#status"
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :driver_requirement, except: [:index, :destroy]
  resources :rides, except: :destroy do
    resources :payments, only: [:new, :create]
    resources :reviews, only: :create
  end

  resources :question, only: :show
end
