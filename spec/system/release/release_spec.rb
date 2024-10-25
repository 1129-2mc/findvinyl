require 'rails_helper'

RSpec.describe "Releases", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe 'リリースの詳細' do
    it '検索結果のリンクから遷移できること' do
      visit '/'
      fill_in '検索ワード', with: '風街ろまん'
      select 'release', from: 'type'
      within(:xpath, "//form[@action='#{search_path}']") do
        find('button[type="submit"]').click
      end
      sleep 10
      click_link '風街ろまん'
      expect(page).to have_current_path("/releases/382255", ignore_query: true), 'リリース詳細へ遷移が正しく機能していません'
      expect(page).to have_content('風街ろまん'), 'リリース詳細へ遷移が正しく機能していません'
    end

    context 'ログインしていない場合' do
      it '「コレクションに追加」をクリックするとログインページにリダイレクトすること' do
        visit '/releases/382255'
        click_on 'コレクションに追加'
        expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
        expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
      end
    end

    context 'ログインしている場合' do
      before do
        login(user)
      end
      it '「コレクションに追加」をクリックするとアイテム作成画面に遷移されること' do
        visit '/releases/382255'
        click_on 'コレクションに追加'
        expect(page).to have_current_path(new_item_path, ignore_query: true), 'アイテム作成画面へ遷移できません'
      end
    end
  end
end
