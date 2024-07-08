# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'cpf_cnpj'
require 'net/http'

# Limpar os dados existentes

def wait_for_elasticsearch
  elasticsearch_url = ENV['ELASTICSEARCH_URL'] || 'http://elasticsearch:9200'
  url = URI(elasticsearch_url)
  loop do
    begin
      res = Net::HTTP.get_response(url)
      break if res.is_a?(Net::HTTPSuccess)
    rescue StandardError
      sleep 1
    end
  end
end

wait_for_elasticsearch

# Criar usuários
2.times do |i|
  user = User.create!(
    email: "teste#{i+1}@gmail.com",
    cpf: CPF.generate,
    name: "teste#{i+1}",
    password: 'password',
    password_confirmation: 'password'
  )

  # Criar contatos para cada usuário
  10.times do
    user.contacts.create!(
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.full_address,
      cpf: CPF.generate
    )
  end
end

puts "Seed data created successfully."