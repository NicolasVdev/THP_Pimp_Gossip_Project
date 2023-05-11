Rails.application.routes.draw do
  resources :gossips do
    resources :comments, only: [:create, :edit, :destroy, :update]
    resources :gossip_likes, only: [:create, :destroy]
  end

  resources :users, only: [:show, :create, :new]
  root to: redirect('/gossips')
  resources :cities, only: [:show]
  resources :sessions, only: [:new, :create, :destroy]

  get '/welcome/:first_name', to: 'welcome#show'
  get '/welcome', to: 'welcome#index'
  get '/contact', to: 'contact#index'
  get '/team', to: 'team#index'
end
