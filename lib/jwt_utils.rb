module JwtUtils
  def self.encode(payload)
    JWT.encode(payload, jwt_secret_key)
  end

  def self.decode(token)
    puts token
    puts jwt_secret_key
    JWT.decode(token, jwt_secret_key).first
  end

  private

  def self.jwt_secret_key
    puts  ENV['DEVISE_JWT_SECRET_KEY']
    ENV['DEVISE_JWT_SECRET_KEY']
  end
end
