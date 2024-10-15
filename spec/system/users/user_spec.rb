require 'rails_helper'

RSpec.describe "ユーザー登録・削除", type: :system do
  include LoginMacros

  describe 'ユーザー登録' do
    context '入力情報正常系' do
      it 'ユーザーが新規作成され、直前のURLがない場合はルートパスに遷移すること' do
        visit '/users/new'
        expect {
          fill_in 'ユーザー名', with: '名前'
          fill_in 'メールアドレス', with: 'vinyllog@example.com'
          fill_in 'パスワード', with: '11223344'
          fill_in 'パスワード確認', with: '11223344'
          click_button '登録'
          expect(page).to have_current_path("/", ignore_query: true), 'トップページに遷移していません'
        }.to change { User.count }.by(1)
        expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
      end

      it 'ユーザーが新規作成され、直前のURLに遷移すること' do
        visit '/shops/map'
        visit '/users/new'
        expect {
          fill_in 'ユーザー名', with: '名前'
          fill_in 'メールアドレス', with: 'vinyllog@example.com'
          fill_in 'パスワード', with: '11223344'
          fill_in 'パスワード確認', with: '11223344'
          click_button '登録'
          page.save_screenshot('screenshot.png')
        }.to change { User.count }.by(1)
        expect(page).to have_current_path('/shops/map'), '直前のURLに遷移していません'
        expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
      end
    end

    context '入力情報異常系' do
      it 'ユーザーが新規登録できない' do
        visit 'users/new'
        expect {
          fill_in 'メールアドレス', with: 'vinyllog@example.com'
          click_button '登録'
        }.to change { User.count }.by(0)
        expect(page).to have_content('ユーザー登録に失敗しました'), 'フラッシュメッセージ「ユーザー登録に失敗しました」が表示されていません'
        expect(page).to have_content('パスワードは8文字以上で入力してください'), 'エラーメッセージ「パスワードは8文字以上で入力してください」が表示されていません'
        expect(page).to have_content('パスワード確認を入力してください'), 'エラーメッセージ「パスワード確認を入力してください」が表示されていません'
        expect(page).to have_content('ユーザー名を入力してください'), 'エラーメッセージ「ユーザー名を入力してください」が表示されていません'
      end
    end
  end

  describe 'ユーザー削除' do
    let(:user) { create(:user) }
    it '削除できること' do
      login(user)
      visit 'profile/edit'
      expect {
        click_on('アカウントを削除する')
        page.accept_confirm
        expect(page).to have_current_path("/", ignore_query: true)
      }.to change(User, :count).by(-1)
      expect(page).to have_content('アカウントを削除しました'), 'フラッシュメッセージ「アカウントを削除しました」が表示されていません'
      expect(User.exists?(user.id)).to be_falsey, 'ユーザーの削除ができていません'
    end
  end
end
