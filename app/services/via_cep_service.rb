class ViaCepService
  include HTTParty
  base_uri 'viacep.com.br/ws'

  def self.get_address(cep)
    response = get("/#{cep}/json/")
    response.parsed_response
  end
end
