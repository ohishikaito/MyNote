class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5)
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
  end

  def update
    @tweet.update(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: 'ツイートを編集しました！'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
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

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
