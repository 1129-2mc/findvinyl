require 'rails_helper'

RSpec.describe ArtistName, type: :model do

  context 'アーティスト名が255文字以内の場合' do
    it '有効であること' do
      artist_name = build(:artist_name, name: 'a' * 255)
      expect(artist_name).to be_valid
    end
  end

  context 'アーティスト名が256文字以上の場合' do
    it '無効であること' do
      artist_name = build(:artist_name, name: 'a' * 256)
      expect(artist_name).to be_invalid
      expect(artist_name.errors[:name]).to include('は255文字以内で入力してください')
    end
  end
end
