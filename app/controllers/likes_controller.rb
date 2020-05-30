class LikesController < ApplicationController
  before_action :set_tweet, only: [:create, :destroy]
  
  def index
    @user = User.find(user_id: params[:user_id])
  end

  def create
    like = Like.create(user_id: current_user.id, tweet_id: @tweet.id)
    like.save
    @tweet.create_notification_like!(current_user)
    # @likes = Like.where(tweet_id: @tweet.id)
    # @tweet.reload
  end
 
  def destroy
    # like = Like.find(params[:id])
    like = Like.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    like.destroy
    # @likes = Like.where(tweet_id: @tweet.id)
    # @tweet.reload
  end

  def set_tweet
    # @tweet = Tweet.find_by(id: params[:tweet_id])
    @tweet = Tweet.find(params[:tweet_id])
  end
  
end