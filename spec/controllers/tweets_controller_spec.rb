require 'rails_helper'

describe TweetsController do

  describe 'GET #index' do

    it "@tweetに正しい値が入っていること" do
      tweets = create_list(:tweet, 3)
      get :index
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "tweets/indexに遷移すること" do
      get :index
      expect(response).to render_template :index
    end
  end

  # describe 'GET #new' do
  #   it "tweets/newに遷移すること" do
  #     get :new
  #     expect(response).to render_template :new
  #   end
  # end

  # describe 'GET #edit' do
  #   it "@tweetに正しい値が入っていること" do
  #     tweet = create(:tweet)
  #     get :edit, params: { id: tweet }
  #     # expect(assigns(:tweet)).to eq tweet
  #   end

  # it "edit.html.erbに遷移すること" do
  #   tweet = create(:tweet)
  #   get :edit, params: { id: tweet }
  #   expect(response).to render_template :edit
  # end

  # describe 'GET #show' do
  #   it "show.html.erbに遷移すること" do
  #     get :show, params: {  id: 1 }
  #   end
  # end

end