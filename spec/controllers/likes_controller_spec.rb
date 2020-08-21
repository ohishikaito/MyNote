# require 'rails_helper'

# describe LikesController do
#   describe "#create" do
#     let(:user){create(:user)}
#     let(:tweet){create(:tweet, user: user)}
#     # let(:params) { { user_id: user.id, tweet_id: tweet.id } }
#     let(:params) { { tweet_id: tweet.id, like: attributes_for(:like) } }

#     context 'log in' do
#       before do
#         login_user user
#       end
#       subject do
#         post :create,
#              params: params
#       end
#       it '保存に成功した場合' do
#         expect { subject }.to change(Like, :count).by(1)
#       end
#     end

#     context "保存に成功した場合" do
#       it 'likeを保存すること' do
#         like = build(:like)
#         expect { like.save }.to change(Like, :count).by(1)
#       end

#       # it 'tweet_indexへリダイレクトすること' do
#       #   subject
#       #   expect(response).to redirect_to(tweet)
#       # end

#     end
#   end
# end
