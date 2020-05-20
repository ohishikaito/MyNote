class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @tweets = @user.tweets.order('updated_at desc').page(params[:page]).per(5)
    @liked_tweet = Tweet.joins(:likes).where(likes: { user: @user })
  end

  def likes
    @user = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end