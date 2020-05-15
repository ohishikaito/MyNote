class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @nickname = @user.nickname
    @tweets = @user.tweets.order('updated_at desc').page(params[:page]).per(5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end