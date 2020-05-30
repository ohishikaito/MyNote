class Tweets::SearchesController < ApplicationController

  def index
    @tweets = Tweet.search(params[:keyword]).includes(:user).order('updated_at desc').page(params[:page]).per(12)
    if params[:tag_name]
      @tweets = Tweet.search(params[:keyword]).includes(:user).order('updated_at desc').page(params[:page]).per(12).tagged_with("#{params[:tag_name]}")
    end
  end

end
