# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

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
  resources :tweets,       only: [:index, :create, :destroy]
  resource  :relationship, only: [:create, :destroy]
  resolve("Relationship") { :relationship }

  get "help",    to: "static_pages#help"
  get "about",   to: "static_pages#about"
  get "contact", to: "static_pages#contact"
end
