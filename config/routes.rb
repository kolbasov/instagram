Rails.application.routes.draw do
  # Authentication
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Search by tag
  get '/search' => 'photos#search', as: :search

  # Users
  get '/:name' => 'users#show', as: :user
  post '/users' => 'users#create'
  get '/:name/edit' => 'users#edit', as: :edit_user
  patch '/:name' => 'users#update'

  # Following/followers
  get '/:name/following' => 'users#following', as: :following_user
  get '/:name/followers' => 'users#followers', as: :followers_user
  resources :relationships, only: [:create, :destroy]

  # Photos
  get '/' => 'photos#index'
  get '/p/new' => 'photos#new', as: :new_photo
  get '/p/:id' => 'photos#show', as: :photo
  post '/photos' => 'photos#create'
  post '/photos/:id/comments' => 'comments#create', as: :comment

  root 'photos#index'
end
