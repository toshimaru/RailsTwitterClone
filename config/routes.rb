# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :tweets,        only: [:index, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get "help",    to: "static_pages#help"
  get "about",   to: "static_pages#about"
  get "contact", to: 'static_pages#contact'

  get    "signup", to: "users#new"
  get    "login",  to: "sessions#new"
  delete "logout", to: "sessions#destroy"

  match "*path" => "application#routing_error", via: :all
end
