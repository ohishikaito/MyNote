require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "アソシエーションのテスト" do
    context "各モデルとのアソシエーションを確認" do
      it "Userとの関連付けはhas_manyであること" do
      User.reflect_on_all_associations(:has_many)
      end

      it "Roomとの関連付けはbelongs_toであること" do
        Room.reflect_on_all_associations(:has_many)
      end

      it "Messageとの関連付けはbelongs_toであること" do
        Message.reflect_on_all_associations(:has_many)
      end
    end
  end
end