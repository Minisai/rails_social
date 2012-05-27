Rails3DeviseRspecCucumber::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users
  resources :users, :only => [:show, :index] do
    resources :microposts, :only => [:create, :destroy]
    resources :albums, :only => [:create, :destroy, :index, :show] do
      resources :photos
    end
  end

  resources :photos, :only => [:create, :destroy]

  resources :microposts, :only => [:create, :destroy]

  resources :friendships

  resources :albums, :only => [:create, :destroy, :index, :show] do
    resources :photos
  end

  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'

  match "/users/:id/friends" => "users#friends", :as => :user_friends
  match "/users/:id" => "users#show", :as => :user_profile

  match "/friends" => "users#friends", :as => :current_user_friends

  match "/news" => "users#news", :as => :news

  match '/home', :to => 'home#index'
  match '/', :to => 'home#index'
  match '/users', :to => 'users#index'

  match "/users/:user_id/albums" => "albums#index", :as => :user_albums


  match "friendships/:action/:id", :controller => 'friendships', :action => /[a-z_]+/i
end
