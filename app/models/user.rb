class User < ApplicationRecord
  has_secure_password

  validates :cpf, presence: :true, cpf: true
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true

  has_many :contacts, dependent: :destroy
end
