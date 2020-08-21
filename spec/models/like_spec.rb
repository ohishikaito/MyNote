require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '正常値と異常値の確認' do
    context 'likeモデルのバリデーション' do
      it "user_idとtweet_idがあれば保存できる" do
        # expect(FactoryBot.build_stubbed(:like)).to be_valid
        expect(FactoryBot.create(:like)).to be_valid
      end

      it "user_idがなければ無効な状態であること" do
        like = build(:like, user_id: nil)
        like.valid?
        expect(like.errors[:user_id]).to include("を入力してください")
      end

      it "tweet_idがなければ無効な状態であること" do
        like = build(:like, tweet_id: nil)
        like.valid?
        expect(like.errors[:tweet_id]).to include("を入力してください")
      end

      it "tweet_idが同じでもuser_idが違うと保存できる" do
        like = create(:like)
        expect(FactoryBot.create(:like, tweet_id: like.tweet_id)).to be_valid
      end

      it "user_idが同じでもtweet_idが違うと保存できる" do
        like = create(:like)
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end

      it "tweet_idとuser_idは一意でなければ保存できない" do
        like = create(:like)
        like2 = build(:like, tweet_id: like.tweet_id, user_id: like.user_id)
        like2.valid?
        expect(like2.errors[:tweet_id]).to include("はすでに存在します")
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Userモデルとのアソシエーション" do
      let(:target) { :user }

      it "Userとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "Tweetモデルとのアソシエーション" do
      let(:target) { :tweet }

      it "Tweetとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
