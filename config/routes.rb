Rails.application.routes.draw do
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
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/create' => 'posts#create'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  get '/' => 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
