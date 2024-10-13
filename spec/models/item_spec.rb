require 'rails_helper'

RSpec.describe Item, type: :model do

  context 'すべてのフィールドが有効な場合' do
    it '有効であること' do
      item = create(:item)
      expect(item).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      item = create(:item)
      item.title = nil
      expect(item).to be_invalid
      expect(item.errors[:title]).to include("を入力してください")
    end
  end

  context 'アーティスト名が存在しない場合' do
    it '無効であること' do
      item = create(:item)
      item.artist_name = nil
      expect(item).to be_invalid
      expect(item.errors[:artist_name]).to include("を入力してください")
    end
  end

  context 'メモが10000文字以下の場合' do
    it '有効であること' do
      user = create(:user)
      title = create(:title)
      artist_name = create(:artist_name)
      item = build(:item, user: user, title: title, artist_name: artist_name, user_note: 'a' * 10000)
      expect(item).to be_valid
    end
  end

  context 'メモが10001文字以上の場合' do
    it '無効であること' do
      user = create(:user)
      title = create(:title)
      artist_name = create(:artist_name)
      item = build(:item, user: user, title: title, artist_name: artist_name, user_note: 'a' * 10001)
      expect(item).to be_invalid
      expect(item.errors[:user_note]).to include("は10000文字以内で入力してください")
    end
  end
end
