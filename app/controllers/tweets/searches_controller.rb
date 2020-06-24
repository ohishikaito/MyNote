class Tweets::SearchesController < ApplicationController
  def index
    @tweets = Tweet.search(params[:keyword]).includes(%i[taggings user]).order('updated_at desc').page(params[:page]).per(12)
  end
end
