require "http"
require "http/headers"
require "json"
require "jwks"

def make_pub_keys(jwks)
  pub_keys = Hash(String, String).new
  unless jwks.values.nil?
    jwks.values.not_nil!.each do |key|
      pub_keys[key.kid] = key.to_pem
    end
  end
  pub_keys
end

module Api::Auth::Auth0Helpers
  alias Auth0JWKS = NamedTuple(kty: String, kid: String, use: String, n: String, e: String, x5c: String)

  class Auth0TokenAuthError < Exception
  end

  AUTH0_DOMAIN_URL    = "https://#{ENV["AUTH0_DOMAIN"]}"
  AUTH0_USER_INFO_URL = "#{AUTH0_DOMAIN_URL}/userinfo"

  @@jwks = JW::Public::KeySets.new("#{AUTH0_DOMAIN_URL}/.well-known/jwks.json")
  @@pub_keys : Hash(String, String) = make_pub_keys(@@jwks)

  def make_pub_keys
    pub_keys = Hash(String, String).new
    unless @@jwks.values.nil?
      @@jwks.values.not_nil!.each do |key|
        pub_keys[key.kid] = key.to_pem
      end
    end
    pub_keys
  end

  # The 'memoize' macro makes sure only one query is issued to find the user
  memoize def current_user? : AuthUser?
    auth_token.try do |value|
      user_from_auth_token(value)
    end
  end

  private def auth_token : String?
    bearer_token || token_param
  end

  private def bearer_token : String?
    context.request.headers["Authorization"]?
      .try(&.gsub("Bearer", ""))
      .try(&.strip)
  end

  private def token_param : String?
    params.get?(:auth_token)
  end

  # validate Auth0 access token.
  private def validate_token(token : String)
    begin
      header = JWT.decode(token: token, verify: false, validate: false)[1]
      raise Auth0TokenAuthError.new unless header["typ"].as_s == "JWT"
      algo = JWT::Algorithm.parse(header["alg"].as_s)
      raise Auth0TokenAuthError.new unless algo.as?(JWT::Algorithm::RS256)
      jwt_public_key_pem = @@pub_keys[header["kid"]]
      decoded_token = JWT.decode(token: token, key: jwt_public_key_pem, algorithm: algo, verify: true, validate: true)
      decoded_token
    rescue ex : Auth0TokenAuthError
      nil
    rescue ex : JWT::DecodeError
      @@jwks = JW::Public::KeySets.new("#{AUTH0_DOMAIN_URL}/.well-known/jwks.json")
      @@pub_keys = make_pub_keys(@@jwks)
      nil
    end
  end

  private def user_from_auth_token(token : String) : AuthUser?
    begin
      decoded_token = self.validate_token(token)
      return nil if decoded_token.nil?
      username = decoded_token[0]["sub"].as_s.sub("|", ".")
      Log.info { "login_user: #{username}" }
      user = AuthUserQuery.new.username(username).first?
      if user.nil?
        SaveAuthUser.create!(username: username)
      else
        return user
      end
    rescue e
      Log.info { e }
      nil
    end
  end
end
