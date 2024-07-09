require 'rails_helper'

RSpec.describe Contact, type: :model do

  it 'is valid with valid attributes' do
    user = build(:contact)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:contact, name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a cpf' do
    user = build(:contact, cpf: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a cep' do
    user = build(:contact, cep: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a address' do
    user = build(:contact, address: nil)
    expect(user).not_to be_valid
  end

  # Searchkick
  describe "searchkick" do
    it "should index name and cpf" do
      contact = create(:contact)
      expect(contact.search_data.keys).to contain_exactly(:name, :cpf)
    end
  end
end
