class HomeController < ApplicationController
  def home
    conn = Faraday.new("https://api.twitter.com") do |req|
      req.headers['Authorization'] = "Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4"
      req.adapter Faraday.default_adapter
    end

    response = conn.get('/1.1/trends/place.json?id=1') #uk = 23424975
    @twitter_response = response.body[1..-2]
    logger.info @twitter_response
  end
end
