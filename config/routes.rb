RenanCodeCom::Application.routes.draw do
  root :to => 'home#index'
  
  get "home/index"

  devise_for :users
  
  resources :championships do
  	resources :games
  	
  	resources :teams

    post "dashboard" => "dashboard#updategame", as: "dashboard"

    get 'dashboard', to: 'dashboard#show', as: 'dashboard'
  end
end