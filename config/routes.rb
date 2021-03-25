# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy] do
    member do
      get :following
      get :followers
    end
  end
  resources :tweets,        only: [:index, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get "help",    to: "static_pages#help"
  get "about",   to: "static_pages#about"
  get "contact", to: 'static_pages#contact'

  match "*path" => "application#routing_error", via: :all
end
