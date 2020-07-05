class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update timeline]
  before_action :set_user, except: %i[index timeline]
  before_action :blocking_edit_user, only: %i[edit update]
  before_action :blocking_edit_test_user, only: %i[edit update]
  before_action :join_room, only: %i[show likes]

  def index
    @users = User.all
  end

  def show
    # 投稿一覧
    @tweets = @user.tweets.includes(:taggings).order('created_at desc').page(params[:page]).per(10)
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = "入力内容に誤りがあります。入力漏れ、文字数をご確認ください。"
      render :edit
    end
  end

  def likes
    @tweets = @user.liked_tweets.includes(%i[taggings user]).order('updated_at desc').page(params[:page]).per(10)
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  def timeline
    if user_signed_in?
      @user = User.find(current_user.id)
      @following_users = @user.following
      @tweets = Tweet.includes(%i[taggings user]).where(user_id: @following_users).order('created_at desc').page(params[:page]).per(10)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :avatar)
  end

  def blocking_edit_user
    redirect_to root_path, alert: "不正な操作です" unless (@user == current_user) || current_user.admin?
  end

  def blocking_edit_test_user
    redirect_to root_path, alert: "ゲストユーザーのため編集できません" if current_user.email == "guest@user"
  end

  def join_room
    if user_signed_in?
      unless @user.id == current_user.id
        @current_user_entry = Entry.where(user_id: current_user.id)
        @user_entry = Entry.where(user_id: @user.id)
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id
              @have_room = true
              @room_id = cu.room_id
            end
          end
        end
        unless @have_room
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end
end
