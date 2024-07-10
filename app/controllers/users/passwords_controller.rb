module Users
  class PasswordsController < ApplicationController
    skip_before_action :authenticate_request

    def forgot
      user = User.find_by(email: params[:user][:email])

      if user
        PasswordResetService.new(user).send_reset_email
        render json: { message: 'Email de recuperação de senha enviado com sucesso.' }, status: :ok
      else
        render json: { error: 'Email não encontrado. Verifique o email digitado.' }, status: :unprocessable_entity
      end
    end

    def reset
      @user = User.find_by(reset_password_token: params[:user][:token])
      if @user
        if @user.update(user_params)
          @user.update(reset_password_token: nil, reset_password_sent_at: nil)
          render json: { message: 'Senha resetada com sucesso.' }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Token inválido ou expirado. Solicite outro email de recuperação de senha.' }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
