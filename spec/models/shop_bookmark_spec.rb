require 'rails_helper'

RSpec.describe ShopBookmark, type: :model do
  context 'すべてのフィールドが有効な場合' do
    it '有効であること' do
      shop_bookmark = build(:shop_bookmark)
      expect(shop_bookmark).to be_valid
    end
  end

  context 'ユーザーとショップの組み合わせがユニークでない場合' do
    it '無効であること' do
      shop_bookmark = create(:shop_bookmark)
      new_bookmark = build(:shop_bookmark, user: shop_bookmark.user, shop: shop_bookmark.shop)
      expect(new_bookmark).to be_invalid
      expect(new_bookmark.errors[:user_id]).to include('はすでに存在します')
    end
  end
end
