class UsersController < ApplicationController
  def create 
    user = User.new(user_params)
    if user.save?
      render json: user, staus: :create
    else
      render json: user.erros, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :cpf, :email, :password, :password_confirmation)
  end
end
