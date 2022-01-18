Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts do
    resources :auctions, only:[:index,:new,:create]
  end
  
end
