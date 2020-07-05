require 'rails_helper'

describe TweetsController do
  context 'ログインしていない場合' do
    describe 'GET #index' do
      before do
        get :index
      end

      it "@tweetに正しい値が入っている" do
        tweets = create_list(:tweet, 3)
        expect(assigns(:tweets)).to match(tweets.sort { |a, b| b.created_at <=> a.created_at })
      end

      it "indexに遷移できる" do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it "showに遷移できる" do
        @tweet = create(:tweet)
        get :show, params: { id: @tweet.id }
      end
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it 'ログイン画面にリダイレクトする' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      before do
        @tweet = create(:tweet)
        get :edit, params: { id: @tweet }
      end

      it 'ログイン画面にリダイレクトする' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    # ログインしていない場合
  end

  # -------------------------------------------------------
  context 'ログインしている場合' do
    let(:user) { create(:user) }
    before do
      login_user user
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it '@tweetに新しいTweetを割り当てる' do
        expect(assigns(:tweet)).to be_a_new(Tweet)
      end

      it "newに遷移できる" do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before do
        @tweet = create(:tweet, user_id: user.id)
        get :edit, params: { id: @tweet.id }
      end

      it "@tweetに正しい値が入っている" do
        expect(assigns(:tweet)).to eq @tweet
      end

      it "editに遷移できる" do
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      let(:params) { { user_id: user.id, tweet: attributes_for(:tweet) } }

      context '保存に成功した場合' do
        subject do
          post :create,
               params: params
        end

        it 'messageを保存すること' do
          expect { subject }.to change(Tweet, :count).by(1)
        end

        it 'tweet_indexへリダイレクトすること' do
          subject
          expect(response).to redirect_to(root_path)
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { user_id: user.id, tweet: attributes_for(:tweet, title: nil, text: nil) } }

        subject do
          post :create,
               params: invalid_params
        end

        it 'messageを保存しないこと' do
          expect { subject }.not_to change(Tweet, :count)
        end

        it 'newに遷移される' do
          subject
          expect(response).to render_template :new
        end
      end
    end
    # ログインしている場合
  end
end
