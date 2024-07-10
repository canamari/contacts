class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'User deleted successfully.' }
  end

  private

  def user_params
    params.require(:user).permit(:name, :cpf, :email, :password, :password_confirmation)
  end
end
