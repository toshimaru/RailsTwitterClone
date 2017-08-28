# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :tweets,        only: [:index, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get    "signup"  => "users#new"
  get    "signin"  => "sessions#new"
  delete "signout" => "sessions#destroy"
  get    "about"   => "static_pages#about"

  match "*path" => "application#routing_error", via: :all
end
