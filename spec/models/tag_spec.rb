require 'rails_helper'

RSpec.describe Tag, type: :model do

  context 'タグが255文字以内の場合' do
    it '有効であること' do
      tag = build(:tag, name: 'a' * 255)
      expect(tag).to be_valid
    end
  end

  context 'タグが256文字以上の場合' do
    it '無効であること' do
      tag = build(:tag, name: 'a' * 256)
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
