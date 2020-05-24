class Tweets::SearchesController < ApplicationController

  def index
    @tweets = Tweet.search(params[:keyword]).includes(:user).order('updated_at desc').page(params[:page]).per(5)
    if params[:tag_name]
      @tweets = Tweet.search(params[:keyword]).includes(:user).order('updated_at desc').page(params[:page]).per(5).tagged_with("#{params[:tag_name]}")
    end
    # end
      # if params[:tag_name]
      #   @tweets = Tweet.tagged_with("#{params[:tag_name]}").includes(:user).order('updated_at desc').page(params[:page]).per(5)
      # end
  end

end

# @tweets = Tweet.search(params[:keyword]).includes(:user).order('updated_at desc').page(params[:page]).per(5)

# def index
#   @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5)
#   if params[:tag_name]
#     @tweets = Tweet.tagged_with("#{params[:tag_name]}").includes(:user).order('updated_at desc').page(params[:page]).per(5)
#   end
# end