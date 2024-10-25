require 'rails_helper'

RSpec.describe "アーティスト情報", type: :system do

  describe 'アーティストの詳細' do
    it '検索結果のリンクから遷移できること' do
      visit '/'
      fill_in '検索ワード', with: 'はっぴいえんど'
      select 'artist', from: 'type'
      within(:xpath, "//form[@action='#{search_path}']") do
        find('button[type="submit"]').click
      end
      sleep 10
      click_link 'はっぴいえんど'
      expect(page).to have_current_path("/artists/136940", ignore_query: true), 'アーティスト詳細へ遷移が正しく機能していません'
      expect(page).to have_content('はっぴいえんど'), 'アーティスト詳細へ遷移が正しく機能していません'
    end
  end
end
