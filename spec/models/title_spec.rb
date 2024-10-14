require 'rails_helper'

RSpec.describe Title, type: :model do

  context 'リリースタイトルが255文字以内の場合' do
    it '有効であること' do
      title = build(:title, name: 'a' * 255)
      expect(title).to be_valid
    end
  end

  context 'リリースタイトルが256文字以上の場合' do
    it '無効であること' do
      title = build(:title, name: 'a' * 256)
      expect(title).to be_invalid
      expect(title.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
