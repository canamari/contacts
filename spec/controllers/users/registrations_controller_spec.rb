require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { 
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          name: 'Test User',
          cpf: CPF.generate
        }
      }
    end

    let(:invalid_attributes) do
      { 
        user: {
          email: '',
          password: 'password123',
          password_confirmation: 'password123',
          name: '',
          cpf: ''
        }
      }
    end

    context 'with valid params' do
      it 'creates a new User and returns a success response' do
        expect {
          post :create, params: valid_attributes, format: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['user']['email']).to eq('test@example.com')
        expect(json_response['user']['name']).to eq('Test User')
      end
    end

    context 'with invalid params' do
      it "doesn't create a new User and returns an error response" do
        expect {
          post :create, params: invalid_attributes, format: :json
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).not_to be(nil)
      end
    end
  end
end
