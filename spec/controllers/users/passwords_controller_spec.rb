require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    DatabaseCleaner.start
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  after do
    DatabaseCleaner.clean
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid email' do
      it 'sends reset password instructions and returns a success response' do
        post :create, params: { user: { email: user.email } }, format: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Instructions for resetting your password have been sent to your email.')
      end
    end

    context 'with invalid email' do
      it 'returns an error response' do
        post :create, params: { user: { email: 'invalid@example.com' } }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Email not found. Please check and try again.')
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    before do
      @token = user.send_reset_password_instructions
    end

    context 'with valid token and password' do
      it 'resets the password and returns a success response' do
        put :update, params: { user: { reset_password_token: @token, password: 'newpassword123', password_confirmation: 'newpassword123' } }, format: :json
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Your password has been successfully updated.')
      end
    end

    context 'with invalid token or password' do
      it 'returns an error response' do
        put :update, params: { user: { reset_password_token: 'invalidtoken', password: 'newpassword123', password_confirmation: 'newpassword123' } }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Reset password token is invalid')
      end

    end
  end
end
