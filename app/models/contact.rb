class Contact < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user

  # Indexar dados relevantes
  settings do
    mappings dynamic: 'false' do
      indexes :name, type: 'text'
      indexes :cpf, type: 'keyword'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^3', 'cpf']
          }
        }
      }
    )
  end
end
