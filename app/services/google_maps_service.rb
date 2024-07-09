class GoogleMapsService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api'

  def self.get_coordinates(address)
    response = get("/geocode/json", query: { address: address, key: ENV['GOOGLE_MAPS_API_KEY'] })
    result = response.parsed_response['results'].first
    result ? result['geometry']['location'] : nil
  end
end
