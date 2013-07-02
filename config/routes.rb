RenanCodeCom::Application.routes.draw do
  get "dashboard/show"

  root :to => 'home#index'

  match "dashboard/updategame" => "dashboard#updategame", as: "dashboard_updategame", method: :get

  match "home/index" => "home#index", as: "home_index", method: :get

  resources :dashboard

  resources :games 
  
  resources :teams

  resources :championships
end