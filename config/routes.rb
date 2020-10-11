Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'tweets#index'
    namespace :tweets do
      resources :searches, only: :index
    end
    resources :tweets do
    collection do
      get :likes, :tags
    end
    resources :donations, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes, :following, :followers, :setting
    end
    get 'timeline', on: :collection
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :rooms, only: [:index, :show, :create]
  resources :notifications, only: :index
  namespace :api, format: 'json' do
    get 'tweets/preview'
  end

end