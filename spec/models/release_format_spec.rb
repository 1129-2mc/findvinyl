require 'rails_helper'

RSpec.describe ReleaseFormat, type: :model do

  context 'フォーマットが255文字以内の場合' do
    it '有効であること' do
      release_format = build(:release_format, name: 'a' * 255)
      expect(release_format).to be_valid
    end
  end

  context 'フォーマットが256文字以上の場合' do
    it '無効であること' do
      release_format = build(:release_format, name: 'a' * 256)
      expect(release_format).to be_invalid
      expect(release_format.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
