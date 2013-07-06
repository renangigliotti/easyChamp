RenanCodeCom::Application.routes.draw do

  root :to => 'home#index'

  match "dashboard/updategame" => "dashboard#updategame", as: "dashboard_updategame", method: :get

  get '/home/index', to: 'home#index', as: 'home'

  get '/dashboard/:id', to: 'dashboard#show', as: 'dashboard'

  resources :games 
  
  resources :teams

  resources :championships
end