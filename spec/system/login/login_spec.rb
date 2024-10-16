require 'rails_helper'

RSpec.describe "ログイン・ログアウト", type: :system do
  include LoginMacros
  let(:general_user) { create(:user, :general) }
  let(:admin_user) { create(:user, :admin) }

  describe '通常画面' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'メールアドレス', with: general_user.email
          fill_in 'パスワード', with: '11223344'
          click_button I18n.t('user_sessions.new.login')
          expect(page).to have_current_path("/", ignore_query: true), 'ログインに失敗しました'
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/login'
          fill_in 'メールアドレス', with: general_user.email
          fill_in 'パスワード', with: '1122'
          click_button I18n.t('user_sessions.new.login')
          expect(page).to have_current_path("/login", ignore_query: true), 'ログイン失敗時にログイン画面に戻ってきていません'
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end

    describe 'ログアウト' do
      before do
        login(general_user)
      end
      it 'ログアウトできること' do
        find('#menuToggle').click
        click_on('ログアウト')
        expect(page).to have_current_path("/", ignore_query: true), 'ログアウトに失敗しました'
        expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
      end
    end
  end

  describe '管理画面' do
    describe 'アクセス' do
      describe 'アクセス失敗' do
        context '管理者以外の場合' do
          before do
            login(general_user)
          end
          it '通常画面ルートパスにリダイレクトされること' do
            visit '/admin'
            expect(page).to have_current_path("/", ignore_query: true), '管理画面へのアクセス失敗時にトップページに戻ってきていません'
          end
        end

        context '管理者の場合' do
          before do
            login(admin_user)
          end
          it 'アクセスできること' do
            visit '/admin'
            expect(page).to have_current_path("/admin", ignore_query: true), '管理画面へのアクセス失敗に失敗しました'
          end
        end
      end
    end

    describe 'ログアウト' do
      before do
        login(admin_user)
      end
      it 'ログアウトできること' do
        visit '/admin'
        click_on('ログアウト')
        expect(page).to have_current_path("/", ignore_query: true), 'ログアウトに失敗しました'
        expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
      end
    end
  end
end
