Rails3DeviseRspecCucumber::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users
  resources :users, :only => [:show, :index]

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/home', :to => 'home#index'
  match '/', :to => 'home#index'
  match '/users', :to => 'users#index'
end
