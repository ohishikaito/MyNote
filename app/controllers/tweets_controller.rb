class TweetsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_tweet, only: %i[edit destroy show update]
  before_action :blocking_edit_tweet, only: %i[edit update destroy]
  before_action :set_available_tags_to_gon, only: %i[new edit]

  def index
    @tweets = Tweet.includes(%i[taggings user]).order('created_at desc').page(params[:page]).per(10)
    @tweets = @tweets.tagged_with(params[:tag_name].to_s) if params[:tag_name]
  end

  def new
    @tweet = Tweet.new
    @tags = Tweet.includes([:taggings]).tag_counts_on(:tags)
  end

  def create
    @tweet = Tweet.create(tweet_params)
    gon.tweet_tags = @tweet.tag_list
    if @tweet.save
      redirect_to root_path, notice: '投稿しました！'
    else
      flash.now[:alert] = "文字数を確認してください。"
      render :new
    end
  end

  def edit
    gon.tweet_tags = @tweet.tag_list
  end

  def update
    @tweet.update(tweet_params)
    gon.tweet_tags = @tweet.tag_list
    if @tweet.save
      redirect_to tweet_path(@tweet.id), notice: '投稿を編集しました！'
    else
      flash.now[:alert] = "文字数を確認してください。"
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order('created_at desc')
    @user = @tweet.user
    @donation = Donation.new
    @donations = @tweet.donations.includes(:user).sum(:amount)
  end

  def destroy
    @tweet.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end

  def likes
    @tweets = Tweet.includes(%i[taggings user]).order('likes_count desc').page(params[:page]).per(10)
  end

  def tags
    @tags = Tweet.includes(:taggings).tag_counts_on(:tags)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :text, :image, :tag_list).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def blocking_edit_tweet
    redirect_to root_path, alert: "不正な操作です" unless (@tweet.user == current_user) || current_user.admin?
  end

  def set_available_tags_to_gon
    gon.available_tags = Tweet.includes(:taggings).tags_on(:tags).pluck(:name)
  end
end
