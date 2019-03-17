Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  get 'users/:user_id/edit' => 'users#edit'
  get 'users/:user_id' => 'users#show'
  get 'signup' => 'users#new'
  get 'login' => 'users#login_form'
  post 'users/create' => 'users#create'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post 'users/:user_id/update' => 'users#update'

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
