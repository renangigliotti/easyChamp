RenanCodeCom::Application.routes.draw do
  root :to => 'championships#index'
  
  resources :championships do
  	resources :games
  	resources :teams

    post "dashboard" => "dashboard#updategame", as: "dashboard"

    get 'dashboard', to: 'dashboard#show', as: 'dashboard'
  end
end