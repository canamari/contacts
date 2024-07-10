# spec/controllers/users/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end


  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test1@example.com', password: 'password') }

    context 'with valid credentials' do
      it 'logs in successfully and returns a JWT token' do
        post :create, params: { user: { email: 'test1@example.com', password: 'password' } }, format: :json
        expect(JSON.parse(response.body)['token']).to be_present
    end
end

context 'with invalid credentials' do
    it 'returns an unauthorized status' do
        post :create, params: { user: { email: 'test2@example.com', password: 'wrong_password' } }, format: :json
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Credenciais inválidas')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    let!(:token) { JwtUtils.encode(user.id) }

    context 'with a valid token' do
      it 'logs out successfully' do

        request.headers['Authorization'] = "Bearer #{token}"
        delete :destroy, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Deslogado com sucesso')
      end
    end
  end
end
