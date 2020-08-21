require 'rails_helper'

RSpec.describe Donation, type: :model do
  let(:donation) { create(:donation) }
  describe '#create' do
    context '保存できる場合' do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(donation).to be_valid
      end

      it "amountが1以上なら保存できる" do
        donation.amount = 1
        expect(donation).to be_valid
      end
    end

    context "保存できない場合" do
      it "user_idがnilの場合は保存できない" do
        donation.user_id = nil
        donation.valid?
        expect(donation.errors[:user]).to include("を入力してください")
      end

      it "tweet_idがnilの場合は保存できない" do
        donation.tweet_id = nil
        donation.valid?
        expect(donation.errors[:tweet]).to include("を入力してください")
      end

      it "amountがnilの場合は保存できない" do
        donation.amount = nil
        donation.valid?
        expect(donation.errors[:amount]).to include("を入力してください")
      end

      it "amountが0の場合は保存できない" do
        donation.amount = 0
        donation.valid?
        expect(donation.errors[:amount]).to include("は0より大きい値にしてください")
      end
    end
  end
end
