Rails.application.routes.draw do
  
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :show] do
    member do
      get :likes
    end
  end
  resources :relationships, only: [:create, :destroy]
  
end
# resourcesでネストして指定する

# shallow trueは諦める
  # ページネーション
  #きいたにまとめる
  # escape_javascript省略してるからね