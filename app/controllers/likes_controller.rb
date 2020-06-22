class LikesController < ApplicationController
  before_action :set_tweet, only: [:create, :destroy]

  def create
    like = Like.create(user_id: current_user.id, tweet_id: @tweet.id)
    like.save
    @tweet.create_notification_like!(current_user)
    @tweet.reload
  end

  def destroy
    # like = Like.find(params[:id])
    like = Like.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    like.destroy
    @tweet.reload
  end

  private
    def set_tweet
      # @tweet = Tweet.find_by(id: params[:tweet_id])
      @tweet = Tweet.find(params[:tweet_id])
    end
  
end