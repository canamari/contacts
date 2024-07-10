class ApplicationController < ActionController::API
  include JwtUtils
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    if token
      begin
        decoded_token_user_id = JwtUtils.decode(token)
        @current_user = User.find(decoded_token_user_id)
      rescue JWT::DecodeError => e
        render json: { error: 'Token inválido' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'Usuário não encontrado' }, status: :unauthorized
      end
    else
      render json: { error: 'Token ausente' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
