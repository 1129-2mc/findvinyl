require 'rails_helper'

RSpec.describe "記録", type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:item) { create(:item, :collection, user: user) }
  let!(:record) do
    create(:record, user: user).tap do |record|
      record.items << item
      record.save
    end
  end

  describe '記録のCRUD' do
    describe '1日間の記録一覧' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit '/records/daily_records/'
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        it '記録・レポートページのカレンダーから選択した日の記録一覧ページに遷移できること' do
          find('#menuToggle').click
          click_on('記録・レポート')
          record_date = record.created_at.to_date
          click_link href: daily_records_path(date: record_date.to_s)
          expect(page).to have_current_path(daily_records_path(date: record_date.to_s)), '記録一覧ページへ遷移できません'
          expect(page).to have_content("記録一覧（#{record_date.strftime('%Y-%m-%d')}）"), '記録一覧のタイトルが正しく表示されていません'
        end

        context 'カレンダーの記録がない日をクリックした場合' do
          it '遷移しないこと' do
            visit '/records'
            no_record_date = record.created_at.to_date + 1.day
            expect(page).not_to have_link(href: daily_records_path(date: no_record_date.to_s)), '記録がない日付がリンクになっています'
            expect(page).to have_current_path('/records'), '意図しないページ遷移が発生しています'
          end
        end
      end
    end

    describe '記録の詳細' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit record_path(record)
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        context '自分の記録' do
          it '記録詳細が表示されること' do
            record_date = record.created_at.to_date
            visit daily_records_path(date: record_date.to_s)
            click_link text: item.title.name
            expect(page).to have_content("記録詳細"), '記録のリンクから記録詳細画面へ遷移できません'
            expect(page).to have_content(item.title.name), '記録詳細に聴いたレコードのタイトルが表示されていません'
            expect(page).to have_content(item.artist_name.name), '記録詳細に聴いたレコードのアーティスト名が表示されていません'
            expect(page).to have_content(record.content), '記録詳細にコメントが表示されていません'
            expect(page).to have_content(record.created_at.strftime("%Y/%m/%d %H:%M")), '記録詳細に記録を作成した日時が表示されていません'
          end
        end

        context '他人の記録' do
          let!(:other_user_record) do
            create(:record, user: another_user).tap do |record|
              record.items << item
              record.save
            end
          end
          it '閲覧できないこと' do
            visit record_path(other_user_record)
            expect(page).to have_content("指定された記録が見つかりません"), 'エラーメッセージ「指定された記録が見つかりません」が表示されていません'
          end
        end
      end
    end

    describe '記録の作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit 'records/new'
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        let!(:item) { create(:item, :collection, user: user) }
        it '記録が作成できること', js: true do
          visit '/records'
          click_on '記録する'
          fill_in 'タイトル・アーティスト名を入力', with: 'タイトル'
          find('button:has(.i-bi-plus-circle)').click
          fill_in 'コメント', with: '記録作成テスト'
          click_on '保存'
          expect(page).to have_content('記録を作成しました'), 'フラッシュメッセージ「記録を作成しました」が表示されていません'
          expect(page).to have_current_path("/records", ignore_query: true), '記録・レポートページへ遷移できません'
        end

        it '記録の作成に失敗すること', js: true do
          visit '/records'
          click_on '記録する'
          fill_in 'コメント', with: '記録作成テスト'
          accept_alert 'レコードが選択されていません。' do
            click_on '保存'
          end
          expect(page).to have_current_path("/records/new", ignore_query: true), '記録の作成に失敗していません'
        end
      end
    end

    describe '記録の更新' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit edit_record_path(record)
          expect(page).to have_current_path("/login", ignore_query: true), 'ログインページへ遷移できません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
        end
        let!(:title) { create(:title, name: '編集後テストタイトル') }
        let!(:artist_name) { create(:artist_name, name: '編集後テストアーティスト名') }
        let!(:item) { create(:item, :collection, user: user, title: title, artist_name: artist_name) }
        it '記録の更新ができること', js: true do
          visit record_path(record)
          find("[data-tip='編集']").click
          fill_in 'タイトル・アーティスト名を入力', with: '編集後'
          find('button:has(.i-bi-plus-circle)').click
          fill_in 'コメント', with: '編集後テストコメント'
          click_on '保存'
          expect(page).to have_content('記録を更新しました'), 'フラッシュメッセージ「記録を更新しました」が表示されていません'
          expect(page).to have_content(item.title.name), '聴いたレコードのタイトルが表示されていません'
          expect(page).to have_content(item.artist_name.name), '記録作成時の聴いたレコードのアーティスト名が表示されていません'
          expect(page).to have_content('編集後テストタイトル'), '記録作成時の更新後の聴いたレコードのタイトルが表示されていません'
          expect(page).to have_content('編集後テストアーティスト名'), '更新後の聴いたレコードのアーティスト名が表示されていません'
          expect(page).to have_content('編集後テストコメント'), '記録詳細に更新後のコメントが表示されていません'
        end

        it '記録の更新に失敗すること', js: true do
          visit edit_record_path(record)
          find('button:has(.i-bi-x-lg)').click
          accept_alert 'レコードが選択されていません。' do
            click_on '保存'
          end
          expect(page).to have_current_path(edit_record_path(record), ignore_query: true), '記録の編集に失敗していません'
        end
      end
    end

    describe '記録の削除' do
      before do
        login(user)
      end
      it '記録の削除ができること', js: true do
        visit record_path(record)
        expect {
          find("[data-tip='削除']").click
          page.accept_confirm
          expect(page).to have_content('記録を削除しました'), 'フラッシュメッセージ「記録を削除しました」が表示されていません'
        }.to change(Record, :count).by(-1)
        expect(page).to have_current_path("/records", ignore_query: true), '記録・レポートページへ遷移できません'
      end
    end
  end
end
