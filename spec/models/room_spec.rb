require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "アソシエーションのテスト" do
      let(:target) { :rooms }
      it "Roomsとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      let(:target) { :messages }
      it "Messagesとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
