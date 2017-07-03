Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

	root 'static_pages#home'

  devise_for :users

  get 'friendships/create'
  get 'friendships/destroy'
  get  '/users',    to:   'users#index'
  get  '/home',    to:   'static_pages#home'
  get  '/about',   to:   'static_pages#about'
  get  '/contact', to:   'static_pages#contact'
end
