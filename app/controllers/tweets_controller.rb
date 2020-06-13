class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :blocking_edit_tweet, only: [:edit, :update, :destroy]
  before_action :set_available_tags_to_gon, only: [:new, :edit]

  def index
    @tweets = Tweet.includes([:taggings, :user]).order('created_at desc').page(params[:page]).per(10)
    if params[:tag_name]
      @tweets = @tweets.tagged_with("#{params[:tag_name]}")
    end
    # ids = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').pluck(:tweet_id))
    # # ids = Tweet.where(id: Like.group(:tweet_id).limit(10).order('count(tweet_id) desc').pluck(:tweet_id))
    # @tweets = ids
    # @tweets = @tweets
    
    # @tweets = Tweet.where(id: ids)
    # if params[:tag_nane]
      # @tweets = @tweets.page(params[:page]).per(12)
  end

  def new
      @tweet = Tweet.new
      @tags = Tweet.includes([:taggings]).tag_counts_on(:tags)
      # @tags = Tweet.tag_counts_on(:tags)
  end

  def create
    @tweet = Tweet.create(tweet_params)
    gon.tweet_tags = @tweet.tag_list
    if @tweet.save
      redirect_to root_path, notice: 'ツイートを投稿しました！'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
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
    @donation = Donation.new
    @donations = @tweet.donations.includes(:user).sum(:amount)
  end

  def destroy
    @tweet.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end

  def likes
    @tweets = Tweet.create_all_ranks
    # if params[:tag_nane]
    # @tweets = Tweet.find(Like.group(:tweet_id).limit(10).order('count(tweet_id) desc').pluck(:tweet_id))
      # @tweets = @tweets.tagged_with("#{params[:tag_name]}")
    # end
    # ids = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').pluck(:tweet_id))
    # # ids = Tweet.where(id: Like.group(:tweet_id).limit(10).order('count(tweet_id) desc').pluck(:tweet_id))
    # @tweets = ids
    # @tweets = @tweets.page(params[:page]).per(12)
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
    unless current_user.admin?
      if @tweet.user.id != current_user.id
        redirect_to root_path, notice: "不正な操作です"
      end
    end
  end

  def set_available_tags_to_gon
    gon.available_tags = Tweet.includes(:taggings).tags_on(:tags).pluck(:name)
  end

end
