Rails3DeviseRspecCucumber::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  #match '/home', :to => 'home#index'
  match '/', :to => 'home#index'
  match '/users', :to => 'users#index'

  devise_for :users
  resources :users, :only => [:show, :index]
end
