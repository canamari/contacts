module Users
  class SessionsController < ApplicationController
    include JwtUtils
    skip_before_action :authenticate_request, only: :create
    
    def create
      user = User.find_by(email: params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        payload = {
          user_id: user.id,
          exp: Time.now
        }

        token = JwtUtils.encode(user.id)
        render json: { user: user, token: token }, status: :ok
      else
        render json: { error: 'Credenciais inválidas' }, status: :unauthorized
      end
    end

    def destroy
      token = request.headers['Authorization']&.split(' ')&.last
      if token
        JwtDenylist.create(jti: token, exp: Time.now)
        render json: { message: 'Deslogado com sucesso' }, status: :ok
      end
      head :no_content
    end
  end
end
