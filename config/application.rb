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

      # clear old trend data
      Trend.delete_all

      Location.all.shuffle.each do |location|
        Rails.logger.info "Gathering data from: #{location.country} -> #{location.name}"
        trends_from_area = conn.get("/1.1/trends/place.json?id=#{location.woeid}")

        unless trends_from_area.status != 200
          trends_json = JSON.parse(trends_from_area.body)
          (0..4).each do |j|
            begin
              trend_name = trends_json[0]['trends'][j]['name']
              # check if the trend exists in the database first
              if Trend.trend_by_name(trend_name).count > 0
                Rails.logger.info " - Trend [#{trend_name}] already exists, creating link"
                # if the trend doesnt exist in the database, create a link instead of a new one
                new_trend_link = TrendDatum.create(
                  location_id: location.id,
                  trend_id: Trend.trend_by_name(trend_name).first.id
                )
                new_trend_link.save
                Rails.logger.info " - Trend Link [#{trend_name}] -> [#{location.country}] Established"
              else
                # try to make a new record for the trend
                new_trend_submission = Trend.create(name: trend_name)

                # if the trend saves in the database, create a link to the location in the link table
                if new_trend_submission.save
                  Rails.logger.info " - Trend [#{trend_name}] successfully created"
                  new_trend_link = TrendDatum.create(location_id: location.id, trend_id: new_trend_submission.id)

                  # if the trend link cannot be created, delete the trend data
                  unless new_trend_link.save
                    new_trend_submission.destroy
                  else
                    Rails.logger.info " - Trend Link [#{trend_name}] -> [#{location.country}] Established"
                  end
                end
              end
            rescue StandardError
              Rails.logger.info '[Twitter API Error] Null data point'
            end
          end
        end
      end

      # available_trends_raw = conn.get('/1.1/trends/available.json')

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
