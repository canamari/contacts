Devise.setup do |config|
  config.navigational_formats = ['*/*', :html, :json]
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise[:jwt_secret_key]
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}],
      ['POST', %r{^/signup$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 30.minutes.to_i
  end
end
