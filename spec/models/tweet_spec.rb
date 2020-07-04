require 'rails_helper'
describe Tweet do
  describe '#create'do
  
    # tweetを保存できる場合
    context 'Can save tweet' do
      # 正しく保存できるか
      it "Can it be saved correctly" do
        expect(build(:tweet)).to be_valid
      end

      # imageがnilの場合でも保存できる
      it "image can be saved as nil" do
        tweet = build(:tweet, image: nil)
        expect(build(:tweet)).to be_valid
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
end