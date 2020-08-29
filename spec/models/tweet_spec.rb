require 'rails_helper'
describe Tweet do
  describe '#create' do
    # tweetを保存できる場合
    context 'Can save tweet' do
      # 正しく保存できるか
      it "Can it be saved correctly" do
        expect(build(:tweet)).to be_valid
      end

      # imageがnilの場合でも保存できる
      it "image can be saved as nil" do
        @tweet = build(:tweet, image: nil)
        expect(@tweet).to be_valid
      end
    end

    # tweetを保存できない場合
    context 'If you can`t save the tweet' do
      # titleとtextがnilの場合は保存できない
      it "Cannot save if title and text are nil" do
        tweet = build(:tweet, title: nil, text: nil)
        tweet.valid?
        expect(tweet.errors[:title]).to include("を入力してください")
      end

      # titleがnilの場合は保存できない
      it "Cannot save if title is nil" do
        tweet = build(:tweet, title: nil)
        tweet.valid?
        expect(tweet.errors[:title]).to include("を入力してください")
      end

      # titleが41文字以上の場合は保存できない
      it "title cannot be saved more than 41 characters" do
        tweet = build(:tweet, title: Faker::Lorem.characters(number: 41))
        tweet.valid?
        expect(tweet.errors[:title]).to include("は40文字以内で入力してください")
      end

      # textがnilの場合は保存できない
      it "Cannot save if text is nil" do
        tweet = build(:tweet, text: nil)
        tweet.valid?
        expect(tweet.errors[:text]).to include("を入力してください")
      end

      # textが1501文字以上の場合は保存できない"
      it "Cannot save if text is more than 1501 characters" do
        tweet = build(:tweet, text: Faker::Lorem.characters(number: 1501))
        tweet.valid?
        expect(tweet.errors[:text]).to include("は1500文字以内で入力してください")
      end

      # user_idがnilの場合は保存できない
      it 'Cannot save if user_id is nil' do
        tweet = build(:tweet, user_id: nil)
        tweet.valid?
        expect(tweet.errors[:user]).to include("を入力してください")
      end
    end
  end

  describe "#search" do
    # 各テストの前にTweetを作成
    before do
      user = create(:user)
      @tweet = create(
        :tweet,
        title: "天気が良い",
        text: "今日は快晴です",
        user: user
      )

      @other_tweet = create(
        :tweet,
        title: "天気が悪い",
        text: "今日は雨です",
        user: user
      )
    end

    context "「晴」で検索した場合、曖昧検索できているか" do
      it "@tweetを返すこと" do
        expect(Tweet.search("晴")).to include(@tweet)
      end

      it "@other_tweetを返さないこと" do
        expect(Tweet.search("晴")).to_not include(@other_tweet)
      end
    end

    context "「快晴」で検索した場合、一致検索できているか" do
      it "@tweetを返すこと" do
        expect(Tweet.search("快晴")).to include(@tweet)
      end

      it "@other_tweetを返さないこと" do
        expect(Tweet.search("快晴")).to_not include(@other_tweet)
      end
    end

    context "検索に一致しないものは表示されないこと" do
      it "「曇り」で検索した場合、0件であること" do
        expect(Tweet.search("曇り")).to be_empty
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:tweet) { create(:tweet) }

    context "Likeモデルとのアソシエーション" do
      let(:target) { :likes }
      it "Likeとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Tweetが削除されたらLikeも削除されること" do
        like = create(:like, tweet_id: tweet.id)
        expect { tweet.destroy }.to change(Like, :count).by(-1)
      end
    end

    context "Commentsモデルとのアソシエーション" do
      let(:target) { :comments }
      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Tweetが削除されたらCommentも削除されること" do
        comment = create(:comment, tweet_id: tweet.id)
        expect { tweet.destroy }.to change(Comment, :count).by(-1)
      end
    end

    context "Notificationsモデルとのアソシエーション" do
      let(:target) { :notifications }
      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Tweetが削除されたらNotificationも削除されること" do
        notification = create(:notification, tweet_id: tweet.id, visitor_id: 1, visited_id: 1)
        expect { tweet.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end
end
