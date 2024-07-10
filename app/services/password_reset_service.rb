class PasswordResetService
  def initialize(user)
    @user = user
  end

  def send_reset_email
    generate_reset_token
    send_email
  end

  private

  def generate_reset_token
    @user.reset_password_token = SecureRandom.urlsafe_base64
    @user.reset_password_sent_at = 2.hours.from_now
    @user.save!
  end

  def send_email
    UserMailer.with(user: @user).password_reset.deliver_now
  end
end
