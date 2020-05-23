class RelationshipsController < ApplicationController
  # before_action :set_user

  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end

  # private

  # def set_user
  # @user = User.find_by(params[:relationship][:follow_id])
  #   @user = User.find_by(params[:follow_id])
  # end

end
