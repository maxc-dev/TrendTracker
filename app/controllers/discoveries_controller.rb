class DiscoveriesController < ApplicationController
  include ActionController::Live
  class TrendingData
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

  def index
    # set default lat/long coords if user not signed in
    @latitude = 0
    @longitude = 0

    # if user is signed in and has accepted the privacy agreement..
    if current_user.present?
      user_privacy = UserPrivacy.user_agreement(current_user.id)
      if user_privacy.present?
        # decrypt coords and overwrite default lat/long variables
        row = user_privacy.first
        crypt = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPTION_KEY'])
        @latitude = crypt.decrypt_and_verify(row.latitude)
        @longitude = crypt.decrypt_and_verify(row.longitude)
      end
    end

    @all_trend_data = json_callback
  end

  def events
    # establish response headers (text stream event)
    response.headers['Content-Type'] = 'text/event-stream'

    # write the json callback from the location database to the sse
    sse = SSE.new(response.stream, event: 'location')
    puts '-> SSE stream link with client established.'
    sse.write(json_callback)

    # sleep the stream to wait for background process to get new trends
    sleep 25
  rescue IOError
    logger.info 'Stream Closed'
  ensure
    sse.close
    response.stream.close
    puts '-> SSE stream link with client closed.'
  end

  # returns a json object of a list of locations and trends
  def json_callback
    trending_data = []

    # sql join statement to get all trends/locations through the link table
    trend_info = TrendDatum.find_by_sql(
      [
        'select locations.x as x, locations.y as y, trends.name as name from trend_data
        inner join locations on trend_data.location_id = locations.id
        inner join trends on trend_data.trend_id = trends.id'
      ]
    )

    # loop every trend/location and store it in an object in a list
    trend_info.each do |trend_data|
      trend_data_point = TrendingData.new(trend_data.x, trend_data.y, trend_data.name)
      unless trend_data_point.nil?
        trending_data.push trend_data_point
      end
    end

    # return list of objects as json
    trending_data.to_json
  end
end
