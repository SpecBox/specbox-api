require "http/client"
require "json"

class Api::CollectPoints::ReverseZipcode < ApiAction
  get "/api/collect-points/reverse_zipcode" do
    search_place = params.get("for_reverse_zipcode")
    begin
      reverse_zipcode_api_key = ENV["ZIPCODE_REVERCE_API_KEY"]
      response = HTTP::Client.get("https://zipcode.milkyfieldcompany.com/api/v1/findzipcode?apikey=#{reverse_zipcode_api_key}&address=#{search_place}")
      if response.status_code == 200
        reverse_zipcode_data = JSON.parse(response.body)
        json({"data": reverse_zipcode_data})
      else
        json({"data": "error"})
      end
    rescue err
      Log.warn { err }
      json({"data": "error"})
    end
  end
end
