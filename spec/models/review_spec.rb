require 'rails_helper'

RSpec.describe Review, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      review = build(:review)
      expect(review).to be_valid
    end
  end

  context 'レビュー本文が存在しない場合' do
    it '無効であること' do
      review = build(:review, content:nil)
      expect(review).to be_invalid
      expect(review.errors[:content]).to include('を入力してください')
    end
  end

  context 'レビュー本文が10000文字以内の場合' do
    it '有効であること' do
      review = build(:review, content: 'a' * 10000)
      expect(review).to be_valid
    end
  end

  context 'レビュー本文が10001文字以上の場合' do
    it '無効であること' do
      review = build(:review, content: 'a' * 10001)
      expect(review).to be_invalid
      expect(review.errors[:content]).to include('は10000文字以内で入力してください')
    end
  end
end
