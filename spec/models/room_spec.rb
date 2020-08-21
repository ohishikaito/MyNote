require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "各モデルとのアソシエーション" do
    let(:entry) { create(:entry) }
    let(:message) { create(:message) }
    let(:association) do
      described_class.reflect_on_association(target)
    end

    # context "Userモデルとのアソシエーション" do
    #   let(:target) { :user }

    #   it "Userとの関連付けはbelongs_toであること" do
    #     expect(association.macro).to  eq :has_many
    #   end
    # end

    context "Roomモデルとのアソシエーション" do
      let(:target) { :entry }

      it "Roomとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :has_many
      end
    end

    context "Messageモデルとのアソシエーション" do
      let(:target) { :message }

      it "Messageとの関連付けはbelongs_toであること" do
        expect(association.macro).to  eq :has_many
      end
    end
  end
end