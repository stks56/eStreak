Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  get 'likes' => 'likes#index'
  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  get 'games' => 'games#index'
  get 'games/:game_name' => 'games#show'

  get 'posts' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:post_id' => 'posts#show'
  get 'posts/:post_id/edit' => 'posts#edit'
  post 'posts/create' => 'posts#create'
  post 'posts/:post_id/update' => 'posts#update'
  post 'posts/:post_id/destroy' => 'posts#destroy'

  get '/' => 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
