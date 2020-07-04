require 'rails_helper'
describe User do
  describe '#create' do

    # userを保存できる場合
    context 'Can save user' do
      # nickname、email、passwordとpassword_confirmationが存在すれば登録できる
      it "You can register if nickname, email, password and password_confirmation exist" do
        expect(build(:user)).to be_valid
      end

      # avatarがnilの場合でも保存できる
      it "Can save even if avatar is nil" do
        user = build(:user, avatar: nil)
        expect(build(:user)).to be_valid
      end

      # nicknameが10文字以内なら保存できる
      it "Can save if nickname is less than 10 characters" do
        user = build(:user, nickname: "あいうえおあいうえおあ")
        expect(build(:user)).to be_valid
      end

      # passwordが6文字以上であれば登録できる
      it "You can register if password is 6 characters or more" do
        user = build(:user, password: "123456")
        user.valid?
      end

    end

    # userが保存できない場合
    context 'If user cannot be saved' do
      # nicknameがない場合は登録できない
      it "If you do not have a nickname, you cannot register" do
        user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      # emailがない場合は登録できない
      it "If you do not have a email, you cannot register" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      # passwordがない場合は登録できない
      it "If you do not have a password, you cannot register" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      # passwordが存在してもpassword_confirmationがない場合は登録できない
      it "Cannot register if password exists but password_confirmation does not exist" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      # nicknameが11文字以上であれば登録できない
      it "Cannot register if nickname is 11 characters or more" do
        user = build(:user, nickname: "あいうえおかきくけこさ")
        user.valid?
        expect(user.errors[:nickname]).to include("は10文字以内で入力してください")
      end

      # 重複したemailが存在する場合登録できない
      it "Unable to register if duplicate email exists" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      # passwordが5文字以下であれば登録できない
      it "Cannot register if password is 5 characters or less" do
        user = build(:user, password: "00000", password_confirmation: "00000")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

    end
  end
end
