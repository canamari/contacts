module Users
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_request, only: :create

    def create
      user = User.new(user_params)

      if user.save
        render json: { user: user }, status: :ok
      else
        render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :cpf, :email, :password)
    end
  end
end
