require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a cpf' do
    user = build(:user, cpf: nil)
    expect(user).not_to be_valid
  end
end
