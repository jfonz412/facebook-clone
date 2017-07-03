Rails.application.routes.draw do

	root 'static_pages#home'

  devise_for :users
  get    '/users',      to:   'users#index'
  #resources  :users, :only[:show, :index] # might need an actual user model for this..?
  post   '/friendship', to:   'friendships#create'
  delete '/friendship', to:   'friendships#destroy'
  get    '/home',       to:   'static_pages#home'
  get    '/about',      to:   'static_pages#about'
  get    '/contact',    to:   'static_pages#contact'
end
