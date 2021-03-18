require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SocialMap
  class Application < Rails::Application
    config.load_defaults 5.2

    config.assets.initialize_on_precompile = false

    config.after_initialize do
      # connect to twitter api
      conn = Faraday.new('https://api.twitter.com') do |req|
        req.headers['Authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAAEH2NQEAAAAALCC2PRaknbdL6krT2%2B96%2FqsbWeg%3DvTURh99p9QF2r1VwbheviLwbfveXCJLOpFfKTvZ4Fk6KcyXhC4'
        req.adapter Faraday.default_adapter
      end

      def set_trend_at_loc(location, trend)
        # if the same trend and location already exist, ignore
        TrendDatum.where(location_id: location.id).destroy_all
        # TODO delete old trend from Trend table if no uses

        # establish new trend loc link
        new_trend_link = TrendDatum.create(
          location_id: location.id,
          trend_id: trend.id
        )
        if new_trend_link.save
          puts " + Trend Link [#{trend.name}] -> [#{location.country}] Established"
        else
          puts " - Trend Link couldn't save?"
        end
      end

      def pull_tweets(conn, loc_index)
        location = Location.from_id(loc_index).first
        puts "> Getting trend for #{location.country}: #{location.name}"
        trends_from_area = conn.get("/1.1/trends/place.json?id=#{location.woeid}")

        if trends_from_area.status == 200
          begin
            trend_name = JSON.parse(trends_from_area.body)[0]['trends'][0]['name']

            # check if the trend exists in the database first
            trend_if_existed = Trend.trend_by_name(trend_name)
            if trend_if_existed.count.positive?
              puts " * Trend [#{trend_name}] already exists, creating link"
              # if the trend doesnt exist in the database, create a link instead of a new one
              set_trend_at_loc(location, trend_if_existed.first)

            else
              # try to make a new record for the trend
              new_trend_submission = Trend.create(name: trend_name)

              # if the trend saves in the database, create a link to the location in the link table
              if new_trend_submission.save
                puts " + Trend [#{new_trend_submission.name}] successfully created"
                set_trend_at_loc(location, new_trend_submission)
              end
            end
          rescue StandardError
            puts '[Twitter API Error] Null data point'
          end
        else
          puts "[Twitter API Error] Status not OK [#{trends_from_area.status}]"
        end
      end

      # new thread to get the twitter api data in the background
      th = Thread.new do
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
            sleep 3
          end
        end
      end
      th.run

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
  end
end
