Rails.application.routes.draw do

  devise_for :users, controllers: {
    # registrations: "users/registrations",
    # sessions: "users/sessions"
  }

  root to: 'tweets#index'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do
    collection do
      get :likes
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes, :following, :followers, :timeline, :setting
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :rooms, only: [:index, :show, :create]
  resources :notifications, only: :index
  resources :activities, only: :index
  
end
# shallow trueは諦める