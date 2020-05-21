class UsersController < ApplicationController
  before_action :set_user, except: [:index, :timeline]

  def index
    @users = User.all
  end

  def show
    @tweets = @user.tweets.order('updated_at desc').page(params[:page]).per(5)
  end

  def likes
  end

  def following
      @users = @user.following
  end

  def followers
      @users = @user.followers
  end

  def timeline
    @tweets_all = Tweet.includes(:user)
    @user = User.find(current_user.id)
    @following_users = @user.following
    @tweets = @tweets_all.where(user_id: @following_users).order('updated_at desc').page(params[:page]).per(5)
    
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end