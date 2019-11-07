Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :driver_requirement, except: [:index, :destroy]
  resources :rides, except: :destroy do
    resources :payments, only: [:new, :create]
    resources :reviews, only: :create
  end

  resources :questions, only: :index

  post 'procesar_pago', to: 'payments#process_payment', as: :procesar
  get 'add_card', to: 'payments#add_card', as: :add_card
end
