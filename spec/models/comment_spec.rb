require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  describe '#create' do
    context '保存できる場合' do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(comment).to be_valid
      end

      it "contentが1文字以上なら保存できる" do
        comment.content = "A" * 1
        expect(comment).to be_valid
      end

      it "contentが1,000文字以内なら保存できる" do
        comment.content = "A" * 1000
        expect(comment).to be_valid
      end
    end

    context "保存できない場合" do
      it "user_idがnilの場合は保存できない" do
        comment.user_id = nil
        comment.valid?
        expect(comment.errors[:user]).to include("を入力してください")
      end

      it "tweet_idがnilの場合は保存できない" do
        comment.tweet_id = nil
        comment.valid?
        expect(comment.errors[:tweet]).to include("を入力してください")
      end

      it "contentがnilの場合は保存できない" do
        comment.content = nil
        comment.valid?
        expect(comment.errors[:content]).to include("を入力してください")
      end

      it "contentが1001文字以上の場合は保存できない" do
        comment.content = "A" * 1001
        comment.valid?
        expect(comment.errors[:content]).to include("は1000文字以内で入力してください")
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Notificationモデルとのアソシエーション" do
      let(:target) { :notifications }

      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Commentが削除されたらNotificationも削除されること" do
        comment = create(:comment)
        notification = create(:notification, comment_id: comment.id, visitor_id: 1, visited_id: 1)
        expect { comment.destroy }.to change(Comment, :count).by(-1)
      end
    end
  end
end
