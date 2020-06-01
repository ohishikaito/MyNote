require 'rails_helper'
describe User do
  describe '#create' do

    it "nickname、email、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      user.valid?
    end

    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "nicknameが11文字以上であれば登録できないこと" do
      user = build(:user, nickname: "あいうえおかきくけこさ")
      user.valid?
      expect(user.errors[:nickname]).to include("は10文字以内で入力してください")
    end

    it "nicknameが10文字以下では登録できること" do
      user = build(:user, nickname: "あいうえおかきくけこ")
      user.valid?
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = build(:user, email: "guest@user")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

  end
end