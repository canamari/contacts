module Users
  class PasswordsController < Devise::PasswordsController
    respond_to :json

    def create
      self.resource = resource_class.find_or_initialize_with_errors(reset_password_keys, resource_params, :not_found)
      if resource.persisted?
        resource.send_reset_password_instructions
        render json: {
          status: { message: 'Instructions for resetting your password have been sent to your email.' }
        }, status: :ok
      else
        render json: {
          status: { message: "Email not found. Please check and try again." }
        }, status: :unprocessable_entity
      end
    end

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      if resource.errors.empty?
        render json: {
          status: { message: 'Your password has been successfully updated.' }
        }, status: :ok
      else
        render json: {
          status: { message: resource.errors.full_messages.join(', ') }
        }, status: :unprocessable_entity
      end
    end

    private

    def resource_params
      params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
    end
  end
end
