class Contact < ApplicationRecord
  searchkick word_start: [:name, :cpf]

  belongs_to :user

  validates :name, :cep, :address, presence: true
  validates :cpf, presence: :true, cpf: true

  def search_data
    {
      name: name,
      cpf: cpf,
      user_id: user_id
    }
  end
end
