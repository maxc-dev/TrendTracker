class HomeController < ApplicationController
  def home
    conn = Faraday.new('https://api.twitter.com') do |req|
      req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4'
      req.adapter Faraday.default_adapter
    end

    file = File.read(Rails.root.join('app/assets/files/location_map.json'))
    @locations = JSON.parse(file)

    @all_trend_data = Array.new

    (1..300).to_a.sort { rand - 0.5 }[0..100].each do |i|
      trends_from_area = conn.get("/1.1/trends/place.json?id=#{@locations[i]['woeid']}")

      if trends_from_area.status != 200
        logger.info "[Twitter API Error!] Error code: #{trends_from_area.status}"
      else
        trends_json = JSON.parse(trends_from_area.body)
        (0..10).each do |j|
          begin
            trend = TrendData.new(@locations[i]['x'], @locations[i]['y'], trends_json[0]['trends'][j]['name'])
          rescue StandardError
            logger.info '[Twitter API Error] Null data point'
          else
            @all_trend_data.push trend
          end
        end
      end
    end

    @all_trend_data = @all_trend_data.to_json

    logger.info @all_trend_data

    # to send to json: coords & list of trends

=begin
    available_trends_raw = conn.get('/1.1/trends/available.json')

    require 'opencage/geocoder'
    geocoder = OpenCage::Geocoder.new(api_key: '7d19c208503d46b485f642615500ffa2')
    (429..467).each do |i|
      location = @locations[i]
      if location.present?
        results = geocoder.geocode(country: location["country"], country_code: location["countryCode"], city: location["name"])
        logger.info "#{i} -> #{results.first.coordinates}"
      end
    end
=end
    #429 is complete - ran out of usage for the next 24 hours

    #@twt_trends_from_area = trends_from_area.body[1..-2]
  end

  class TrendData
    def initialize(x, y, trend)
      @type = 'Feature'
      @geometry = Geometry.new(x, y)
      @properties = Properties.new(trend)
    end
  end

  class Geometry
    def initialize(x, y)
      @type = 'Point'
      @coordinates = [y, x]
    end
  end

  class Properties
    def initialize(title)
      @title = title
    end
  end
end
