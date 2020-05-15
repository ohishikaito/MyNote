class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]

  def index
    @tweets = Tweet.all
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
    params.require(:tweet).permit(:title, :text, :image)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
