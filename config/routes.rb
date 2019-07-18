Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  post '/graphql', to: 'graphql#execute'

  get 'flollower/create'
  get 'flollower/destroy'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users, only: [:show]

  post 'follower/:id/create' => 'follower#create'
  delete 'follower/:id/destroy' => 'follower#destroy'

  get 'likes' => 'likes#index'
  post 'likes/:post_id/create' => 'likes#create'
  delete 'likes/:post_id/destroy' => 'likes#destroy'

  get 'games' => 'games#index'
  get 'games/:game_name' => 'games#show'

  resources :posts

  get '/' => 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
