module Users
  class SessionsController < Devise::SessionsController
    include JwtUtils

    respond_to :json
    skip_before_action :verify_authenticity_token, if: :json_request?

    private

    def json_request?
      request.format.json?
    end

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: {
          status: { code: 200, message: 'Logged in successfully.' },
          data: resource,
          token: generate_jwt_token(resource)
        }, status: :ok
      else
        render json: {
          status: { message: "Invalid email or passsssword." }
        }, status: :unauthorized
      end
    end

    def generate_jwt_token(user)
      payload = { sub: user.id }
      JwtUtils.encode(payload)
    end

    def respond_to_on_destroy
      jwt_payload = JwtUtils.decode(request.headers['Authorization'].split(' ').last)
      current_user = User.find(jwt_payload['sub'])
      if current_user
        render json: {
          status: 200,
          message: 'Logged out successfully.'
        }, status: :ok
      else
        render json: {
          status: 401,
          message: 'User has no active session.'
        }, status: :unauthorized
      end
    end
  end
end
