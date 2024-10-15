module LoginMacros
  def login(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: '11223344'
    click_button I18n.t('user_sessions.new.login')
    expect(page).to have_content('ログインしました'), 'ログインに失敗しました'
  end
end
