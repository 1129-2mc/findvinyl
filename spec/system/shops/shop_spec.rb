require 'rails_helper'

RSpec.describe "Shops", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe 'ショップのCRUD' do
    describe 'ショップ詳細' do
      it '地図の情報ウィンドウのリンクからショップ詳細画面に遷移できること', js: true do
        visit '/'
        click_button 'お店を探す'
        sleep 10
        page.execute_script(<<~JS)
          const marker = document.querySelector('div[role="button"]');
          if (marker) {
            const clickEvent = new MouseEvent('click', {
              bubbles: true,
              cancelable: true,
              view: window
            });
            marker.dispatchEvent(clickEvent);
          }
        JS
        click_on '詳細を見る'
        expect(page).to have_content('Jazzy Sport Shimokitazawa'), 'ショップ詳細に遷移できません'
      end

      context 'ログインしていない場合' do
        it 'ブックマークボタンが表示されないこと', js: true do
          visit '/shops/7'
          expect(page).not_to have_css('.i-bi-bookmark'),'ブックマークボタンが表示されています'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        it 'ブックマークボタンが表示されること', js: true do
          visit '/shops/7'
          expect(page).to have_css('.i-bi-bookmark'),'ブックマークボタンが表示されていません'
        end
      end
    end

    describe 'ブックマークしたショップ一覧' do
      describe 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit 'shops/bookmark_shops'
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      describe 'ログインしている場合' do
        before do
          login(user)
        end
        it 'サイドバーのリンクからブックマークしたお店一覧へ移動できること' do
          find('#menuToggle').click
          click_on('ブックマークしたお店')
          expect(page).to have_current_path("/shops/bookmark_shops", ignore_query: true), 'サイドバーのリンクからブックマークしたお店一覧へ遷移できません'
        end

        context 'ブックマークしたショップが1件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            find('#menuToggle').click
            click_on('ブックマークしたお店')
            expect(page).to have_content('ブックマークしたお店はありません'), 'ブックマークしたお店が一件もない場合、「ブックマークしたお店はありません」というメッセージが表示されていません'
          end
        end

        context 'ブックマークしたショップがある場合' do
          context '6件以下の場合' do
            before do
              [1, 2, 4, 5, 6, 7].each do |shop_id|
                shop = Shop.find(shop_id)
                user.bookmark(shop)
              end
            end
            it 'ページングが表示されないこと' do
              visit 'shops/bookmark_shops'
              expect(page).not_to have_selector('.pagination'), 'ページングが表示されています'
            end
          end

          context '7件以上ある場合' do
            before do
              [1, 2, 4, 5, 6, 7, 8].each do |shop_id|
                shop = Shop.find(shop_id)
                user.bookmark(shop)
              end
            end
            it 'ページングが表示されること' do
              visit 'shops/bookmark_shops'
              expect(page).to have_selector('.pagination'), 'ページングが表示されていません'
            end
          end
        end
      end
    end

    describe 'レビューしたショップ一覧' do
      describe 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit 'shops/review_shops'
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      describe 'ログインしている場合' do
        before do
          login(user)
        end
        it 'サイドバーのリンクからレビューしたお店一覧へ移動できること' do
          find('#menuToggle').click
          click_on('レビューしたお店')
          expect(page).to have_current_path("/shops/review_shops", ignore_query: true), 'サイドバーのリンクからレビューしたお店一覧へ遷移できません'
        end

        context 'レビューしたショップが1件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            find('#menuToggle').click
            click_on('レビューしたお店')
            expect(page).to have_content('レビューしたお店はありません'), 'ブックマークしたお店が一件もない場合、「レビューしたお店はありません」というメッセージが表示されていません'
          end
        end

        context 'レビューしたショップがある場合' do
          context '6件以下の場合' do
            before do
              [1, 2, 4, 5, 6, 7].each do |shop_id|
                Review.create!(
                  user: user,
                  shop: Shop.find(shop_id),
                  content: "テストレビュー#{shop_id}"
                )
              end
            end
            it 'ページングが表示されないこと' do
              visit 'shops/review_shops'
              expect(page).not_to have_selector('.pagination'), 'ページングが表示されています'
            end
          end

          context '7件以上ある場合' do
            before do
              [1, 2, 4, 5, 6, 7, 8].each do |shop_id|
                Review.create!(
                  user: user,
                  shop: Shop.find(shop_id),
                  content: "テストレビュー#{shop_id}"
                )
              end
            end
            it 'ページングが表示されること' do
              visit 'shops/review_shops'
              expect(page).to have_selector('.pagination'), 'ページングが表示されていません'
            end
          end
        end
      end
    end
  end

  describe 'ショップ検索' do
    context 'ショップ名での検索機能を検証' do
      it '該当するショップが表示されること', js: true do
        visit '/shops/map'
        fill_in '店名・住所で検索', with: 'pianola records'
        within(:xpath, "//form[@action='#{map_shops_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        page.execute_script(<<~JS)
          const marker = document.querySelector('div[role="button"]');
          if (marker) {
            const clickEvent = new MouseEvent('click', {
              bubbles: true,
              cancelable: true,
              view: window
            });
            marker.dispatchEvent(clickEvent);
          }
        JS
        expect(page).to have_content('pianola records'), 'ショップ名での検索機能が正しく機能していません'
      end
    end

    context '住所での検索機能を検証' do
      it '該当するショップが表示されること', js: true do
        visit '/shops/map'
        fill_in '店名・住所で検索', with: '横須賀市本町'
        within(:xpath, "//form[@action='#{map_shops_path}']") do
          find('button[type="submit"]').click
        end
        sleep 10
        page.execute_script(<<~JS)
          const marker = document.querySelector('div[role="button"]');
          if (marker) {
            const clickEvent = new MouseEvent('click', {
              bubbles: true,
              cancelable: true,
              view: window
            });
            marker.dispatchEvent(clickEvent);
          }
        JS
        expect(page).to have_content('Disk Shop Lucky'), '住所での検索機能が正しく機能していません'
      end
    end

    context '検索条件に該当するショップがない場合' do
      it '1件もない旨のメッセージが表示されること', js: true do
        visit '/shops/map'
        fill_in '店名・住所で検索', with: '存在しない店'
        within(:xpath, "//form[@action='#{map_shops_path}']") do
          find('button[type="submit"]').click
        end
        expect(page).to have_content('検索結果が見つかりませんでした'), '検索結果が一件もない場合、フラッシュメッセージ「検索結果が見つかりませんでした」が表示されていません'
      end
    end
  end
end
