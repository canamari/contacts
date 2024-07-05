class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :cpf, presence: :true, cpf: true
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
end
