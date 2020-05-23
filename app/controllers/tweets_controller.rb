class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5)
  end

  def likes
    # @all_ranks = Note.find(Like.group(:note_id).order('count(note_id) desc').limit(3).pluck(:note_id))
    # @all_tweets = Tweet.find(Like.group(:tweet_id).pluck(:tweet_id))
    # @tweets = @all_tweets.order('updated_at desc').page(params[:page]).per(5)
    # @tweets = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').pluck(:tweet_id)).page(params[:page]).per(5)
    @tweets = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').pluck(:tweet_id))
    # a = Tweet.joins(:likes).group(:tweet_id).count
    # b = Hash[a.sort_by{ |_, v| -v }].keys
    # @tweets = Tweet.where(id: b)
  end

  def new
      @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: 'ツイートを投稿しました！'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
      render :new
    end
  end

  def edit
    if @tweet.user_id != current_user.id
      redirect_to root_path, notice: "不正な操作です"
    end
  end

  def update
    @tweet.update(tweet_params)
    if @tweet.save
      redirect_to tweet_path(@tweet.id), notice: 'ツイートを編集しました！'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order('created_at desc')
    @user = @tweet.user
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end
  
  private

  def tweet_params
    params.require(:tweet).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
