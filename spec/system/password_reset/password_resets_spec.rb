require 'rails_helper'

RSpec.describe "パスワードリセット", type: :system do
  let(:user) { create(:user) }

  it 'パスワードが変更できる' do
    visit '/password_resets/new'
    fill_in 'Email', with: user.email
    click_on '送信'
    expect(page).to have_content('パスワードリセット手順を送信しました'), 'フラッシュメッセージ「パスワードリセット手順を送信しました」が表示されていません'
    visit edit_password_reset_path(user.reload.reset_password_token)
    fill_in 'Password', with: '12345678'
    fill_in 'Confirm Password', with: '12345678'
    click_button '更新'
    expect(page).to have_current_path("/login", ignore_query: true), 'パスワードリセット後にログイン画面に遷移していません'
    expect(page).to have_content('パスワードを変更しました'), 'フラッシュメッセージ「パスワードを変更しました」が表示されていません'
  end
end
