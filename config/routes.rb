Rails.application.routes.draw do
	root 'static_pages#home'

  devise_for :users
  post   '/posts',      to:   'posts#create'
  delete '/posts',      to:   'posts#destroy'
  get    '/users',      to:   'users#index'
  get    '/user/:id',   to:   'users#show', as: 'user'
  post   '/friendship', to:   'friendships#create'
  delete '/friendship', to:   'friendships#destroy'
  patch  '/friendship', to:   'friendships#update'
  get    '/home',       to:   'static_pages#home'
  get    '/about',      to:   'static_pages#about'
  get    '/contact',    to:   'static_pages#contact'
  post   '/like',       to:   'likes#create'  
  delete '/unlike',     to:   'likes#destroy'
  post   '/comments',   to:   'comments#create'
  delete '/comments',   to:   'comments#destroy'
end
