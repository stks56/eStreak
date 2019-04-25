Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get 'signup' => 'devise/registrations#new', as: :new_user_registration
    post 'signup' => 'devise/registrations#create', as: :user_registration
    get 'signup/cancel' => 'devise/registrations#cancel', as: :cancel_user_registration
    get 'user' => 'devise/registrations#edit', as: :edit_user_registration
    patch 'user' => 'devise/registrations#update', as: nil
    put 'user' => 'devise/registrations#update', as: :update_user_registration
    delete 'user' => 'devise/registrations#destroy', as: :destroy_user_registration
    get 'password' => 'devise/passwords#new', as: :new_user_password
    post 'password' => 'devise/passwords#create', as: :user_password
    get 'password/edit' => 'devise/passwords#edit', as: :edit_user_password
    patch 'password' => 'devise/passwords#update'
    put 'password' => 'devise/passwords#update', as: :update_user_password
  end
  resources :users

  get 'users/auth/twitter' => 'omniauth_callbacks#passthru'
  get 'users/auth/twitter/callback' => 'omniauth_callbacks#twitter'

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
