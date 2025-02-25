module JwtUtils
  def self.encode(payload)
    JWT.encode(payload, jwt_secret_key)
  end

  def self.decode(token)
    JWT.decode(token, jwt_secret_key).first
  end

  private

  def self.jwt_secret_key
    ENV['DEVISE_JWT_SECRET_KEY']
  end
end
