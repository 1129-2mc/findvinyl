class UserMailer < ApplicationMailer
  default_url_options[:host] = 'vinyllog.jp'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: t('defaults.password_reset'))
  end

  def email_reconfirmation(user)
    @user = User.find(user.id)
    @token = user.generate_confirmation_token
    @url = confirm_email_url(token: @token)
    mail(to: @user.new_email,
         subject: t('defaults.confirm_change_email'))
  end
end
