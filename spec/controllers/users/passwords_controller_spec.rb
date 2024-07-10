require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid email' do
      it 'sends reset password instructions and returns a success response' do
        post :forgot, params: { user: { email: user.email } }, format: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        puts json_response
        expect(json_response['message']).to eq('Email de recuperação de senha enviado com sucesso.')
      end
    end

    context 'with invalid email' do
      it 'returns an error response' do
        post :forgot, params: { user: { email: 'invalid@example.com' } }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Email não encontrado. Verifique o email digitado.')
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user, reset_password_token: 'token_valid') }

    context 'with valid token and password' do
      it 'resets the password and returns a success response' do
        puts user
        put :reset, params: { user: { token: 'token_valid', password: 'newpassword123', password_confirmation: 'newpassword123' } }, format: :json
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Senha resetada com sucesso.')
      end
    end

    context 'with invalid token or password' do
      it 'returns an error response' do
        
        put :reset, params: { user: { token: 'invalidtoken', password: 'newpassword123', password_confirmation: 'newpassword123' } }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Token inválido ou expirado. Solicite outro email de recuperação de senha.')
      end

    end
  end
end
