# frozen_string_literal: true

Rails.application.routes.draw do
  root "welcome#index"

  get    "home",   to: "home#index"
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get    "signup", to: "users#new"
  resources :users, only: [:index, :show, :edit, :create, :update, :destroy] do
    member do
      get :following
      get :followers
    end
  end
  resources :tweets,       only: [:index, :create, :destroy]
  resource  :relationship, only: [:create, :destroy]
  resolve("Relationship") { :relationship }

  get "help",  to: "static_pages#help"
  get "about", to: "static_pages#about"
end
