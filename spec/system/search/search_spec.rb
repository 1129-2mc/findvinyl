require 'rails_helper'

RSpec.describe "アーティスト名・リリースタイトル検索機能", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  before do
    visit '/'
  end

  context 'アーティスト名' do
    context '検索条件に該当するアーティストがある場合' do
      it '該当するアーティストが表示されること' do
        fill_in '検索ワード', with: 'はっぴいえんど'
        select 'artist', from: 'type'
        within(:xpath, "//form[@action='#{search_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        expect(page).to have_content('はっぴいえんど'), 'アーティスト名での検索機能が正しく機能していません'
      end
    end

    context '検索条件に該当するアーティストがない場合' do
      it '1件もない旨のメッセージが表示されること' do
        fill_in '検索ワード', with: '無いアーティスト名'
        select 'artist', from: 'type'
        within(:xpath, "//form[@action='#{search_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        expect(page).to have_content('検索結果が見つかりませんでした'), '検索結果が一件もない場合、「検索結果が見つかりませんでした」というメッセージが表示されていません'
      end
    end
  end

  context 'リリースタイトル' do
    context '検索条件に該当するリリースタイトルがある場合' do
      it '該当するリリースタイトルが表示されること' do
        fill_in '検索ワード', with: '風街ろまん'
        select 'release', from: 'type'
        within(:xpath, "//form[@action='#{search_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        expect(page).to have_content('風街ろまん'), 'リリースタイトルでの検索機能が正しく機能していません'
      end
    end

    context '検索条件に該当するリリースタイトルがない場合' do
      it '1件もない旨のメッセージが表示されること' do
        fill_in '検索ワード', with: '無いリリースタイトル'
        select 'release', from: 'type'
        within(:xpath, "//form[@action='#{search_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        expect(page).to have_content('検索結果が見つかりませんでした'), '検索結果が一件もない場合、「検索結果が見つかりませんでした」というメッセージが表示されていません'
      end
    end
  end
end
