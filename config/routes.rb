Rails.application.routes.draw do

  devise_for :users, :controllers => {
    sessions: 'users/sessions' # Devise::sessionsクラスを継承していることを明示
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest' # ゲストログイン用メソッド
  end

  root to: 'tweets#index' # トップページ
    namespace :tweets do
      resources :searches, only: :index # 検索機能
    end
    resources :tweets do
    collection do
      get :likes, :tags # 人気投稿とタグ一覧
    end
    resources :donations, only: [:create, :destroy] # 寄付機能
    resources :likes, only: [:create, :destroy] # いいね機能
    resources :comments, only: [:create, :edit, :update, :destroy] # コメント機能
  end

  namespace :api, format: 'json' do
    get 'tweets/preview' # プレビュー用API。controllers/api/tweets_controller#previewメソッドを参照
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

end