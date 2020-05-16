class Tweets::SearchesController < ApplicationController

  def index
    @tweets = Tweet.search(params[:keyword]).order('updated_at desc').page(params[:page]).per(5)
  end

end
