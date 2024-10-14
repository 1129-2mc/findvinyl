require 'rails_helper'

RSpec.describe Record, type: :model do

  context 'すべてのフィールドが有効な場合' do
    it '有効であること' do
      record = build(:record)
      expect(record).to be_valid
    end
  end

  context '関連するitemがない場合' do
    it '無効であること' do
      record = build(:record)
      record.items = []
      expect(record).to be_invalid
      expect(record.errors[:items]).to include('を入力してください')
    end
  end

  context 'コメントが10000文字以下の場合' do
    it '有効であること' do
      record = build(:review, content: 'a' * 10000)
      expect(record).to be_valid
    end
  end

  context 'コメントが10001文字以上の場合' do
    it '無効であること' do
      record = build(:review, content: 'a' * 10001)
      expect(record).to be_invalid
      expect(record.errors[:content]).to include('は10000文字以内で入力してください')
    end
  end
end
