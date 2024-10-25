require 'rails_helper'

RSpec.describe "ショップブックマーク", type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:shop) { Shop.find(1) }

  describe 'ブックマーク機能' do
    before(:each) do
      login(user)
      user.shop_bookmarks.destroy_all
    end

    it 'ブックマークができること', js: true do
      visit shop_path(shop)
      find("#bookmark-button-for-shop-#{shop.id}").click
      expect(current_path).to eq(shop_path(shop)), 'ブックマーク作成後にショップ詳細画面が表示されていません'
      expect(page).to have_css("#unbookmark-button-for-shop-#{shop.id}"), 'idがunbookmark-button-for-shop-#{shop.id}のリンクが表示されていません'
    end

    it 'ブックマークを外せること', js: true do
      visit shop_path(shop)
      find("#bookmark-button-for-shop-#{shop.id}").click
      find("#unbookmark-button-for-shop-#{shop.id}").click
      expect(current_path).to eq(shop_path(shop)), 'ブックマーク解除後にショップ詳細画面が表示されていません'
      expect(page).to have_css("#bookmark-button-for-shop-#{shop.id}"), 'idがbookmark-button-for-shop-#{shop.id}のリンクが表示されていません'
    end
  end
end
