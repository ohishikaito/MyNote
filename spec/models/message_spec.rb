require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { create(:message) }
  describe '#create' do
    context '保存できる場合' do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(message).to be_valid
      end

      it "messageが1文字以上なら保存できる" do
        message.message = "A" * 1
        expect(message).to be_valid
      end

      it "messageが1,000文字以内なら保存できる" do
        message.message = "A" * 1000
        expect(message).to be_valid
      end
    end

    context "保存できない場合" do
      it "user_idがnilの場合は保存できない" do
        message.user_id = nil
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end

      it "room_idがnilの場合は保存できない" do
        message.room_id = nil
        message.valid?
        expect(message.errors[:room]).to include("を入力してください")
      end

      it "messageがnilの場合は保存できない" do
        message.message = nil
        message.valid?
        expect(message.errors[:message]).to include("を入力してください")
      end

      it "messageが1001文字以上の場合は保存できない" do
        message.message = "A" * 1001
        message.valid?
        expect(message.errors[:message]).to include("は1000文字以内で入力してください")
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

    context "Roomモデルとのアソシエーション" do
      let(:target) { :room }

      it "Roomとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end