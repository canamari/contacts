class Contact < ApplicationRecord
  searchkick word_start: [:name, :cpf]

  belongs_to :user

  def search_data
    {
      name: name,
      cpf: cpf
    }
  end
end
