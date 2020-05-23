class CommentsController < ApplicationController
  before_action :set_tweet, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @tweet.comments.create(comment_params)
    if @comment.save
      @tweet = @comment.tweet
      @tweet.create_notification_comment!(current_user, @comment.id)
        if gets_all_comments
          @comment = Comment.new
        end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
        gets_all_comments
    end
  end


  def destroy
    if @comment.destroy
        gets_all_comments
    end
  end

  private

  def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
  end

  def set_comment
      @comment = Comment.find(params[:id])
  end

  def gets_all_comments
    @comments = @tweet.comments.includes(:user).order('created_at desc')
  end

  def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

end
