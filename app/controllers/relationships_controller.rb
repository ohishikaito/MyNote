class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
      # flash[:success] = 'ユーザーをフォローしました'
      redirect_to user_path(@user)
    # else
      # flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      # redirect_to @user
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
      # flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    # else
      # flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      # redirect_to @user
  end

  private

  def set_user
    # @user = User.find_by(params[:relationship][:follow_id])
    @user = User.find_by(params[:follow_id])
  end

end
