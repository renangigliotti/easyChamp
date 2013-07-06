RenanCodeCom::Application.routes.draw do

  root :to => 'home#index'

  match "dashboard/updategame" => "dashboard#updategame", as: "dashboard_updategame", method: :get

  match "home/index" => "home#index", as: "home_index", method: :get

  get '/dashboard/:id', to: 'dashboard#show', as: 'dashboard'

  resources :games 
  
  resources :teams

  resources :championships
end