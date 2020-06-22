class UsersController < ApplicationController
  before_action :set_user, except: [:index, :timeline]
  before_action :blocking_edit_user, only: [:edit, :update]
  before_action :blocking_edit_test_user, only: [:edit, :update]
  before_action :user_join_room, only: [:show, :likes]
  
  def index
    @users = User.all
  end

  def show
    #投稿一覧
    @tweets = @user.tweets.includes(:taggings).order('created_at desc').page(params[:page]).per(10)
  end

  def edit
  end 

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: 'ユーザー情報を更新しました'
    else 
      render :edit
    end
  end

  def likes
    @tweets = @user.liked_tweets.includes([:taggings, :user]).order('updated_at desc').page(params[:page]).per(10)
  end

  def following
      @users = @user.following
  end

  def followers
      @users = @user.followers
  end

  def timeline
    @user = User.find(current_user.id)
    @following_users = @user.following
    @tweets = Tweet.includes([:taggings, :user]).where(user_id: @following_users).order('created_at desc').page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

    def user_params
      params.require(:user).permit(:nickname, :email, :avatar)
    end

  def blocking_edit_user
    unless current_user.admin?
      if @user.id != current_user.id
        redirect_back(fallback_location: root_path)
        flash[:notice] = "不正な操作です"
      end
    end
  end

  def blocking_edit_test_user
    if current_user.email == "guest@user"
      flash[:notice] = "ゲストユーザーのため編集できません"
      redirect_back(fallback_location: root_path)
    end
  end

  def user_join_room
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @haveRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @haveRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

end