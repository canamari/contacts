FactoryBot.define do
  factory :user do
    cpf { CPF.generate }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
