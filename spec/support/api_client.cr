require "http/client"

class ApiClient < Lucky::BaseHTTPClient
  app AppServer.new

  def initialize
    super
    headers("Content-Type": "application/json")
  end

  def self.auth(user : AuthUser)
    token = get_auth0_token
    new.headers("Authorization": token)
  end
end

def get_auth0_token
  auth0_client_id = ENV["AUTH0_TEST_USER_CLIENT_ID"]
  auth0_client_secret = ENV["AUTH0_TEST_USER_CLIENT_SECRET"]
  auth0_domain = ENV["AUTH0_DOMAIN"]
  auth0_audience = ENV["AUTH0_AUDIENCE"]
  auth0_token_url = "https://#{auth0_domain}/oauth/token"
  header = HTTP::Headers{"Accept" => "application/json", "Content-Type" => "application/json"}
  body = {
    "client_id" => auth0_client_id,
    "client_secret" => auth0_client_secret,
    "audience" => auth0_audience,
    "grant_type" => "client_credentials"
  }.to_json
  res = HTTP::Client.post(auth0_token_url, headers: header, body: body)
  JSON::Parser.new(res.body).parse["access_token"]
end
