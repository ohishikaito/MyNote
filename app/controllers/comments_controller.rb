class CommentsController < ApplicationController
  before_action :set_tweet, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @tweet.comments.create(comment_params)
    if @comment.save
      @tweet.create_notification_comment!(current_user, @comment.id)
      gets_all_comments
      @comment = Comment.new
    end
  end

  def edit; end

  def update
    gets_all_comments if @comment.update(comment_params)
  end

  def destroy
    gets_all_comments if @comment.destroy
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

  def blocking_edit_comment
    unless current_user.admin?
      redirect_to root_path, notice: "不正な操作です" if @comment.user_id != current_user.id
    end
  end
end
