Rails.application.routes.draw do
  devise_for :users
  get "rides/:id/status", to: "rides#status", as: :ride_status
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :driver_requirement, except: [:index, :destroy]
  resources :rides, except: :destroy do
    get 'payments/add_card', to: 'payments#add_card', as: :add_card
    post 'add_payment', to: 'payments#add_payment', as: :procesar
    resources :payments, only: [:new, :create]
    resources :reviews, only: :create
  end

  resources :questions, only: :index

  # routes to change
  get 'make_payment', to: 'payments#make_payment', as: :make_payment
end
