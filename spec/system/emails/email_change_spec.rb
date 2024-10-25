require 'rails_helper'

RSpec.describe "EmailsChanges", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  before do
    login(user)
  end

  it 'メールアドレスを変更できる' do
    visit '/email/edit'
    fill_in 'Email', with: 'new_email@example.com'
    click_on '送信'
    expect(page).to have_content('送信完了'), '「送信完了」というメッセージが表示されていません'
    visit confirm_email_path(token: user.reload.confirmation_token)
    expect(page).to have_current_path("/login", ignore_query: true), 'メールアドレス変更後にログイン画面に遷移していません'
    expect(page).to have_content('メールアドレスを更新しました'), 'フラッシュメッセージ「メールアドレスを更新しました」が表示されていません'
    fill_in 'メールアドレス', with: 'new_email@example.com'
    fill_in 'パスワード', with: '11223344'
    click_button I18n.t('user_sessions.new.login')
    expect(page).to have_current_path("/", ignore_query: true), '新しいメールアドレスでのログインに失敗しました'
  end
end
