FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    cep { Faker::Address.postcode }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    cpf { CPF.generate }
    user nil # Assuming user is optional, set to nil
  end
end
