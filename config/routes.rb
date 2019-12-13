# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts
  resources :users

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end
end
