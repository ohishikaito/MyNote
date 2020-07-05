require 'rails_helper'
describe User do
  describe '#create' do
    before do
      @user = build(:user)
    end

    # userを保存できる場合
    context 'Can save user' do
      # nickname、email、passwordとpassword_confirmationが存在すれば登録できる
      it "You can register if nickname, email, password and password_confirmation exist" do
        expect(@user).to be_valid
      end

      # avatarがnilの場合でも保存できる
      it "Can save even if avatar is nil" do
        # user = build(:user, avatar: nil)
        @user.avatar = nil
        expect(@user).to be_valid
      end

      # nicknameが10文字以内なら保存できる
      it "Can save if nickname is less than 10 characters" do
        @user.nickname = "あ" * 10
        expect(@user).to be_valid
      end

      # passwordが6文字以上であれば登録できる
      it "You can register if password is 6 characters or more" do
        @user.password = "1" * 6
        @user.password_confirmation = "1" * 6
        expect(@user).to be_valid
      end
    end

    # userが保存できない場合
    context 'If user cannot be saved' do
      # nicknameがない場合は登録できない
      it "If you do not have a nickname, you cannot register" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors[:nickname]).to include("を入力してください")
      end

      # emailがない場合は登録できない
      it "If you do not have a email, you cannot register" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include("を入力してください")
      end

      # passwordがない場合は登録できない
      it "If you do not have a password, you cannot register" do
        @user.password = ""
        @user.valid?
        expect(@user.errors[:password]).to include("を入力してください")
      end

      # passwordが存在してもpassword_confirmationがない場合は登録できない
      it "Cannot register if password exists but password_confirmation does not exist" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      # nicknameが11文字以上であれば登録できない
      it "Cannot register if nickname is 11 characters or more" do
        @user.nickname = "あ" * 11
        @user.valid?
        expect(@user.errors[:nickname]).to include("は10文字以内で入力してください")
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
        @user.password = @user.password_confirmation = "a" * 5
        @user.valid?
        expect(@user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

    describe '一意性の検証' do
      it 'メールアドレスは大文字小文字を区別せず扱うこと' do
        @user = create(:user, email: 'sample@example.com')
        another_user = build(:user, email: 'SAMPLE@EXAMPLE.COM')
        another_user.valid?
        expect(another_user.errors).to be_added(:email, :taken, value: 'sample@example.com')
      end
    end

    describe 'パスワードの検証' do
      it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
        @user.password = 'password'
        @user.password_confirmation = 'pass'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it 'パスワードが暗号化されていること' do
        expect(@user.encrypted_password).to_not eq 'password'
      end
    end

    describe 'フォーマットの検証' do
      it 'メールアドレスが正常なフォーマットの場合、有効であること' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
  end
end
