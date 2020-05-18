Rails.application.routes.draw do
  
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: :show
  
end

# shallow trueは諦める
  # ページネーション
  #きいたにまとめる
  # escape_javascript省略してるからね