# spec/controllers/users/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    DatabaseCleaner.start
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  after do
    DatabaseCleaner.clean
  end


  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test1@example.com', password: 'password') }

    context 'with valid credentials' do
      it 'logs in successfully and returns a JWT token' do
        post :create, params: { user: { email: 'test1@example.com', password: 'password' } }, format: :json
        expect(JSON.parse(response.body)['status']['message']).to eq('Logged in successfully.')
        expect(JSON.parse(response.body)['token']).to be_present
    end
end

context 'with invalid credentials' do
    it 'returns an unauthorized status' do
        post :create, params: { user: { email: 'test2@example.com', password: 'wrong_password' } }, format: :json
        expect(response).to have_http_status(:unauthorized)
        puts JSON.parse(response.body)['error']
        expect(JSON.parse(response.body)['error']).to eq('Invalid Email or password.')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    let!(:token) { JwtUtils.encode(sub: user.id) }

    context 'with a valid token' do
      it 'logs out successfully' do
        request.headers['Authorization'] = "Bearer #{token}"
        delete :destroy, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Logged out successfully.')
      end
    end

    context 'with an invalid token' do
      it 'returns an unauthorized status' do
        request.headers['Authorization'] = "Bearer invalid_token"
        delete :destroy, format: :json
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message']).to eq('User has no active session.')
      end
    end
  end
end
