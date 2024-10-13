require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do

    it 'ユーザー名・メールアドレス・パスワードがあり、パスワードは8文字以上であれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスはユニークであること' do
      user1 = create(:user)
      user2 = build(:user)
      user2.email = user1.email
      user2.valid?
      expect(user2.errors[:email]).to include('はすでに存在します')
    end

    it 'ユーザー名・メールアドレス・パスワード・パスワード確認は必須項目であること' do
      user = build(:user)
      user.email = nil
      user.name = nil
      user.password = nil
      user.password_confirmation = nil
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
      expect(user.errors[:name]).to include('を入力してください')
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
      expect(user.errors[:password_confirmation]).to include('を入力してください')
    end

    it 'ユーザー名は255文字以下であること' do
      user = build(:user)
      user.name = 'a' * 256
      user.valid?
      expect(user.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
