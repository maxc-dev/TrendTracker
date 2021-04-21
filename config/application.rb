require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SocialMap
  class Application < Rails::Application
    config.load_defaults 5.2

    config.assets.initialize_on_precompile = false

    def database_exists?
      ActiveRecord::Base.connection
    rescue StandardError
      puts 'Database has NOT been initialized'
      false
    else
      puts 'Database has been initialized'
      true
    end

    config.after_initialize do
      if database_exists? && TrendDatum.table_exists?
        background
      end
    end

    def background
      # connect to twitter api
      conn = Faraday.new('https://api.twitter.com') do |req|
        req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4'
        req.adapter Faraday.default_adapter
      end


      # new thread to get the twitter api data in the background
      begin
        Thread.new do
          Rails.application.executor.wrap do
            # randomly selects an element from the array of locations every 5 seconds
            locations = (1..467).to_a
            loop do
              if locations.size.zero?
                locations = (1..467).to_a
              end

              location_index = locations.sample
              locations.delete location_index
              pull_tweets(conn, location_index)
              sleep 14
            end
          end
        end
      rescue StandardError
        puts '[Thread Exception]'
      end

      # gets the coordinates of a city
=begin
  require 'opencage/geocoder'
  geocoder = OpenCage::Geocoder.new(api_key: '7d19c208503d46b485f642615500ffa2')
  (465..465).each do |i|
    location = @locations[i]
    if location.present?
      results = geocoder.geocode(country: location["country"], country_code: location["countryCode"], city: location["name"])
      if results.nil? || results.first.nil?
        logger.info "#{i} -> No Coords for #{location["country"]}"
      else
        logger.info "#{i} -> #{results.first.coordinates}"
      end
    end
  end
=end
    end

    def set_trend_at_loc(location, trend)
      if TrendDatum.exists?(location_id: location.id)
        TrendDatum.where(location_id: location.id).update(trend_id: trend.id)
        puts " + Updated Trend at  -> [#{location.country} - #{location.name}] -> [#{trend.name}]"
      else
        # establish new trend loc link
        new_trend_link = TrendDatum.create(location_id: location.id, trend_id: trend.id)
        if new_trend_link.save
          puts " + Trend Link [#{trend.name}] -> [#{location.country} - #{location.name}] Established"
        else
          puts " - Trend Link couldn't save?"
        end
      end
    end

    def pull_tweets(conn, loc_index)
      location = Location.from_id(loc_index).limit(1).first
      if location.present?
        puts "> Getting trend for #{location.country}: #{location.name}"
        trends_from_area = conn.get("/1.1/trends/place.json?id=#{location.woeid}")

        if trends_from_area.status == 200
          begin
            trend_name = JSON.parse(trends_from_area.body)[0]['trends'][0]['name']
            trend = Trend.find_or_create_by(name: trend_name)
            set_trend_at_loc(location, trend)
          rescue StandardError
            puts '[Twitter API Error] Null data point'
          end
        else
          puts "[Twitter API Error] Status not OK [#{trends_from_area.status}]"
        end
      else
        puts ' - Database location seed not initialized.'
      end
    end
  end
end
