require 'rails_helper'

describe TweetsController do

  describe 'GET #index' do
    before do
      get :index
    end
    it "@tweetに正しい値が入っていること" do
      tweets = create_list(:tweet, 3)
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end
    it "indexに遷移すること" do
      expect(response.status).to eq(200)
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end
    it '@tweetに新しいTweetを割り当てること' do
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end
    it "newに遷移すること" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      @tweet = create(:tweet)
      get :edit, params: { id: @tweet }
    end
    it "@tweetに正しい値が入っていること" do
      expect(assigns(:tweet)).to eq @tweet
    end
    it "editに遷移すること" do
      expect(response).to render_template :edit
    end
  end

  # describe 'GET #show' do
  #   it "show.html.erbに遷移すること" do
  #     get :show, params: {  id: 1 }
  #   end
  # end

end