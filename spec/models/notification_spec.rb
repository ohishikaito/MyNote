require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:association) do
    described_class.reflect_on_association(target)
  end
  # belongs_to :tweet, optional: true
  # belongs_to :comment, optional: true
  # belongs_to :message, optional: true
  # belongs_to :room, optional: true

  context "Messageモデルとのアソシエーション" do
    let(:target) { :message }

    it "Messageとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Tweetモデルとのアソシエーション" do
    let(:target) { :tweet }

    it "Tweetとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Roomモデルとのアソシエーション" do
    let(:target) { :room }

    it "Roomとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "Commentモデルとのアソシエーション" do
    let(:target) { :comment }

    it "Commentとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "visitorとのアソシエーション" do
    let(:target) { :visitor }

    it "Visitorとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end

  context "visitedとのアソシエーション" do
    let(:target) { :visited }

    it "Visitedとの関連付けはbelongs_toであること" do
      expect(association.macro).to eq :belongs_to
    end
  end
end