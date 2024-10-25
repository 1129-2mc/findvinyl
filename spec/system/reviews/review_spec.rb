require 'rails_helper'

RSpec.describe "ショップレビュー", type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:shop) { Shop.find(1) }
  let!(:review_by_user) { create(:review, user: user, shop: shop) }
  let!(:review_by_another_user) { create(:review, user: another_user, shop: shop) }

  describe 'レビューのCRUD' do
    before do
      visit '/shops/1'
    end

    describe 'レビュー一覧' do
      it 'ショップ詳細にレビュー一覧が表示されること' do
        expect(page).to have_content(review_by_user.content), 'レビューの本文が表示されていません'
        expect(page).to have_content(review_by_user.created_at.strftime("%Y/%m/%d %H:%M")), 'レビューの作成日時が表示されていません'
        expect(page).to have_content(review_by_user.user.name), 'レビューの投稿者のユーザー名が表示されていません'
      end
    end

    describe 'レビューの作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          click_on 'レビューを書く'
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
        end
      end

      describe 'ログインしている場合' do
        before do
          login(user)
        end
        it 'レビューが作成できること', js: true do
          click_on 'レビューを書く'
          fill_in 'レビュー内容', with: 'テストレビュー本文'
          click_on '投稿'
          review = shop.reviews.last
          expect(page).to have_content('テストレビュー本文'), 'レビューの本文が表示されていません'
          expect(page).to have_content(review.created_at.strftime("%Y/%m/%d %H:%M")), 'レビューの作成日時が表示されていません'
          expect(page).to have_content(review.user.name), 'レビューの投稿者のユーザー名が表示されていません'
        end
      end
    end

    describe 'レビューの編集' do
      before do
        login(user)
      end
      context '他人のレビューの場合' do
        it '編集ボタン・削除ボタンが表示されないこと' do
          within "#review_#{review_by_another_user.id}" do
            expect(page).not_to have_css('.i-bi-pencil'), '他人のレビューに対して編集アイコンが表示されています'
            expect(page).not_to have_css('.i-bi-trash3'), '他人のレビューに対して削除アイコンが表示されています'
          end
        end
      end

      context '自分のレビューの場合' do
        it '編集できること', js: true do
          within "#review_#{review_by_user.id}" do
            find("[data-tip='編集']").click
          end
          fill_in 'review[content]', with: '編集後テストレビュー本文'
          click_on '更新'
          expect(page).to have_content('レビューを更新しました'), 'フラッシュメッセージ「レビューを更新しました」が表示されていません'
          expect(page).to have_content('編集後テストレビュー本文'), '編集後のレビュー本文が表示されていません'
        end
      end
    end

    describe 'レビューの削除' do
      before do
        login(user)
      end
      it 'レビューを削除できること', js: true do
        within "#review_#{review_by_user.id}" do
          find("[data-tip='削除']").click
        end
        page.accept_confirm
        expect(page).to have_content('レビューを削除しました'), 'フラッシュメッセージ「レビューを削除しました」が表示されていません'
      end
    end
  end
end
