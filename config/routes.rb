Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  get "rides/:id/status", to: "rides#status", as: :ride_status

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :driver_requirement, except: [:destroy]
  get "rides/:id/status", to: "rides#status", as: :ride_status
  resources :rides, except: :destroy do
    get 'payments/add_card', to: 'payments#add_card', as: :add_card
    post 'add_payment', to: 'payments#add_payment', as: :procesar
    resources :payments, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :questions, only: :index


  # routes to change
  get 'make_payment', to: 'payments#make_payment', as: :make_payment
end
