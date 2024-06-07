require "http"
require "http/headers"
require "json"
require "jwks"

def make_pub_keys(jwks)
  pub_keys = Hash(String, String).new
  if jwks
    if jwks.values
      jwks.values.not_nil!.each do |key|
        pub_keys[key.kid] = key.to_pem
      end
    end
  end
  pub_keys
end

def fetch_jwks(jwks_url, retry_cnt = 10, sleep_interval = 5)
  Log.info { "Start fetching jwks" }
  begin
    jwks = JW::Public::KeySets.new(jwks_url)
    Log.info { "Successful fetched jwks" }
    return jwks
  rescue ex
    Log.error { ex }
    Log.error { "Fetching jwks is failed! Retry #{retry_cnt} times." }
    retry_cnt.times do |cnt|
      sleep sleep_interval
      begin
        jwks = JW::Public::KeySets.new(jwks_url)
        Log.info { "Successful fetched jwks" }
        return jwks
      rescue
        Log.error { ex }
        Log.error { "Fetching jwks is failed! Retry #{retry_cnt - (cnt + 1)} times." }
      end
    end
  end
end

module Api::Auth::Auth0Helpers
  alias Auth0JWKS = NamedTuple(kty: String, kid: String, use: String, n: String, e: String, x5c: String)

  class Auth0TokenAuthError < Exception
  end

  AUTH0_DOMAIN_URL    = "https://#{ENV["AUTH0_DOMAIN"]}"
  AUTH0_USER_INFO_URL = "#{AUTH0_DOMAIN_URL}/userinfo"
  JWKS_URL            = "#{AUTH0_DOMAIN_URL}/.well-known/jwks.json"

  @@jwks : JW::Public::KeySets? = fetch_jwks(JWKS_URL)
  @@pub_keys : Hash(String, String) = make_pub_keys(@@jwks)

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
      @@jwks = fetch_jwks(JWKS_URL)
      @@pub_keys = make_pub_keys(@@jwks) unless @@jwks.nil?
      nil
    end
  end

  private def user_from_auth_token(token : String) : AuthUser?
    begin
      decoded_token = self.validate_token(token)
      return nil if decoded_token.nil?
      username = decoded_token[0]["sub"].as_s.sub("|", ".")
      user = AuthUserQuery.new.username(username).first?
      if user.nil?
        SaveAuthUser.create!(username: username, date_joined: Time.local)
      else
        return user
      end
    rescue e
      Log.info { e }
      nil
    end
  end
end
