class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    redirect_to root_path
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
    redirect_to root_path
  end

  def show
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
