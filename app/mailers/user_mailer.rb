class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @reset_url = "#{ENV['APP_URL']}/password/reset?token=#{@user.reset_password_token}"
    mail(to: @user.email, subject: 'Recuperação de senha')
  end
end
