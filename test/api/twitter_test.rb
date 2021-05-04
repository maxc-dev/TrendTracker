require 'test_helper'

class TwitterTest < ActiveSupport::TestCase
  def test_connection
    conn = Faraday.new('https://api.twitter.com') do |req|
      req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4'
      req.adapter Faraday.default_adapter
    end

    assert conn.present?

    trends_from_do = conn.get("/1.1/trends/place.json?id=1")
    assert_equal 200, trends_from_do.status

    conn.close
  end

  def test_invalid_connection
    conn = Faraday.new('https://api.twitter.com') do |req|
      req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC3'
      req.adapter Faraday.default_adapter
    end

    assert conn.present?

    trends_from_do = conn.get("/1.1/trends/place.json?id=1")
    assert_equal 401, trends_from_do.status

    conn.close
  end

  def test_trends_exist_at_location
    conn = Faraday.new('https://api.twitter.com') do |req|
      req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4'
      req.adapter Faraday.default_adapter
    end

    location = locations(:do)
    trends_from_do = conn.get("/1.1/trends/place.json?id=#{location.woeid}")
    assert_equal 200, trends_from_do.status
    trend_name = JSON.parse(trends_from_do.body)[0]['trends'][0]['name']
    assert trend_name.present?

    location = locations(:gb)
    trends_from_gb = conn.get("/1.1/trends/place.json?id=#{location.woeid}")
    assert_equal 200, trends_from_do.status
    trend_name = JSON.parse(trends_from_gb.body)[0]['trends'][0]['name']
    assert trend_name.present?

    location = locations(:mx)
    trends_from_mx = conn.get("/1.1/trends/place.json?id=#{location.woeid}")
    assert_equal 200, trends_from_do.status
    trend_name = JSON.parse(trends_from_mx.body)[0]['trends'][0]['name']
    assert trend_name.present?

    conn.close
  end
end