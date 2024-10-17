require 'rails_helper'

RSpec.describe "アイテム", type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:collection_item) { create(:item, :collection, user: user) }
  let(:want_item) { create(:item, :want, user: user) }

  describe 'アイテムのCRUD' do
    describe 'アイテム一覧' do
      context 'ログインしていない場合' do
        context 'コレクション一覧' do
          it 'ログインページにリダイレクトされること' do
            visit '/collection_items'
            expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
            expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
          end
        end

        context '欲しいもの一覧' do
          it 'ログインページにリダイレクトされること' do
            visit '/want_items'
            expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
            expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
          end
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        it 'サイドバーのリンクからコレクションリストへ遷移できること' do
          find('#menuToggle').click
          click_on('コレクションリスト')
          expect(page).to have_current_path("/collection_items", ignore_query: true), 'サイドバーのリンクからコレクションリストへ遷移できません'
        end

        it 'サイドバーのリンクから欲しいものリストへ移動できること' do
          find('#menuToggle').click
          click_on('欲しいものリスト')
          expect(page).to have_current_path("/want_items", ignore_query: true), 'サイドバーのリンクから欲しいものリストへ遷移できません'
        end

        context 'アイテムが一件もない場合' do
          context 'コレクション' do
            it '何もない旨のメッセージが表示されること' do
              find('#menuToggle').click
              click_on('コレクションリスト')
              expect(page).to have_content('コレクションがありません'), 'コレクションが一件もない場合、「コレクションがありません」というメッセージが表示されていません'
            end
          end

          context '欲しいもの' do
            it '何もない旨のメッセージが表示されること' do
              find('#menuToggle').click
              click_on('欲しいものリスト')
              expect(page).to have_content('欲しいものがありません'), '欲しいものが一件もない場合、「欲しいものがありません」というメッセージが表示されていません'
            end
          end
        end

        context 'アイテムがある場合' do
          context 'コレクション' do
            it 'コレクション一覧が表示されること' do
              collection_item
              find('#menuToggle').click
              click_on('コレクションリスト')
              expect(page).to have_current_path("/collection_items", wait: 10)
              expect(page).to have_content(collection_item.title.name, wait: 10), 'コレクションリストにコレクションのタイトルが表示されていません'
              expect(page).to have_content(collection_item.artist_name.name), 'コレクションリストにコレクションのアーティスト名が表示されていません'
              collection_item.tags.each do |tag|
                expect(page).to have_content(tag.name), 'コレクションリストにコレクションのタグが表示されていません'
              end
            end

            context '10件以下の場合' do
              let!(:collection_items) { create_list(:item, 10, :collection, user: user) }
              it 'ページングが表示されないこと' do
                visit '/collection_items'
                expect(page).not_to have_selector('.pagination'), 'ページングが表示されています'
              end
            end

            context '11件以上ある場合' do
              let!(:collection_items) { create_list(:item, 11, :collection, user: user) }
              it 'ページネーションが表示されること' do
                visit '/collection_items'
                expect(page).to have_selector('.pagination'), 'ページングが表示されていません'
              end
            end
          end

          context '欲しいもの' do
            it '欲しいもの一覧が表示されること' do
              want_item
              find('#menuToggle').click
              click_on('欲しいものリスト')
              expect(page).to have_current_path("/want_items", wait: 10)
              expect(page).to have_content(want_item.title.name, wait: 10), '欲しいものリストに欲しいもののタイトルが表示されていません'
              expect(page).to have_content(want_item.artist_name.name), '欲しいものリストに欲しいもののアーティスト名が表示されていません'
              want_item.tags.each do |tag|
                expect(page).to have_content(tag.name), '欲しいものリストに欲しいもののタグが表示されていません'
              end
            end

            context '10件以下の場合' do
              let!(:want_items) { create_list(:item, 10, :want, user: user) }
              it 'ページングが表示されないこと' do
                visit '/want_items'
                expect(page).not_to have_selector('.pagination'), 'ページングが表示されています'
              end
            end

            context '11件以上ある場合' do
              let!(:want_items) { create_list(:item, 11, :want, user: user) }
              it 'ページネーションが表示されること' do
                visit '/want_items'
                expect(page).to have_selector('.pagination'), 'ページングが表示されていません'
              end
            end
          end
        end
      end
    end

    describe 'アイテムの詳細' do
      context 'ログインしていない場合' do
        let!(:item) { create(:item, :collection, user: user) }
        it 'ログインページにリダイレクトされること' do
          visit item_path(item)
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        let!(:item) { create(:item, :collection, user: user) }
        context '自分のアイテム' do
          it 'アイテムの詳細が表示されること' do
            visit '/collection_items'
            expect(page).to have_link(item.title.name, wait: 10)
            click_link(item.title.name, exact: true)
            expect(page).to have_content("コレクション詳細"), 'コレクションのリンクからコレクション詳細画面へ遷移できません'
            expect(page).to have_content(item.title.name), 'コレクションリストにコレクションのタイトルが表示されていません'
            expect(page).to have_content(item.artist_name.name), 'コレクションリストにコレクションのアーティスト名が表示されていません'
            item.tags.each do |tag|
              expect(page).to have_content(tag.name), 'コレクションリストにコレクションのタグが表示されていません'
            end
          end
        end

        context '他人のアイテム' do
          let(:other_user_item) { create(:item, :collection, user: another_user) }
          it '閲覧できないこと' do
            visit item_path(other_user_item)
            expect(page).to have_content("指定されたアイテムが見つかりません"), 'エラーメッセージ「指定されたアイテムが見つかりません」が表示されていません'
          end
        end
      end
    end

    describe 'アイテムの作成' do
      context 'ログインしていない場合' do
      end

      context 'ログインしている場合' do
        before do
          login(user)
          visit '/'
        end
        context 'コレクション' do
          it 'コレクションが作成できること' do
          end

          it 'コレクションの作成に失敗すること' do
          end
        end

        context '欲しいもの' do
          it '欲しいものが作成できること' do
          end

          it '欲しいものの作成に失敗すること' do
          end
        end
      end
    end

    describe 'アイテムの編集' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
        end
      end

      context 'ログインしている場合' do
        context '自分のアイテム' do
          context 'コレクション' do
            it '編集できること' do
            end

            it '編集に失敗すること' do
            end
          end

          context '欲しいもの' do
            it '編集できること' do
            end

            it '編集できること' do
            end
          end
        end

        context '他人のアイテム' do
          it '編集フォームにアクセスできないこと' do
          end
        end
      end
    end

    describe '欲しいものの移動' do
      it 'コレクションリストに移動できること' do
      end
    end

    describe 'アイテムの削除' do
      it 'アイテムの削除ができること' do
      end
    end

    describe 'アイテム検索' do
      it '' do
      end
    end
  end
end
