require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:entry) { create(:entry) }
  describe '#create' do
    context "保存できる場合" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(entry).to be_valid
      end
    end

    context "保存できない場合" do
      it "user_idがnilの場合は保存できない" do
        entry.user_id = nil
        entry.valid?
        expect(entry.errors[:user]).to include("を入力してください")
      end

      it "room_idがnilの場合は保存できない" do
        entry.room_id = nil
        entry.valid?
        expect(entry.errors[:room]).to include("を入力してください")
      end
    end

    context "一意性の検証" do
      it "user_idとroom_idの組み合わせは一意でなければ保存できない" do
        entry2 = build(:entry, user_id: entry.user_id, room_id: entry.room_id)
        entry2.valid?
        expect(entry2.errors[:room_id]).to include("はすでに存在します")
      end

      it "room_idが同じでもuser_idが違うと保存できる" do
        user2 = create(:user)
        entry2 = build(:entry, user_id: user2.id, room_id: entry.room_id)
        expect(entry2).to be_valid
      end

      it "user_idが同じでもroom_idが違うと保存できる" do
        room2 = create(:room)
        entry2 = build(:entry, user_id: entry.user_id, room_id: room2.id)
        expect(entry2).to be_valid
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