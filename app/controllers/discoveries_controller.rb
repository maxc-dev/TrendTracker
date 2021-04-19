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
    # if user is present zoom in on their location
    @latitude = 0
    @longitude = 0
    if current_user.present?
      user_privacy = UserPrivacy.user_agreement(current_user.id)
      if user_privacy.present?
        row = user_privacy.first
        crypt = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPTION_KEY'])
        @latitude = crypt.decrypt_and_verify(row.latitude)
        @longitude = crypt.decrypt_and_verify(row.longitude)
        puts @latitude
        puts @longitude
      end
    end

    @all_trend_data = json_callback
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream, event: 'location')
    sse.write(json_callback)
    sleep 25
  rescue IOError
    logger.info 'Stream Closed'
  ensure
    sse.close
    response.stream.close
  end

  def json_callback
    trending_data = []
    trend_info = TrendDatum.find_by_sql(
      [
        'select locations.x as x, locations.y as y, trends.name as name from trend_data
        inner join locations on trend_data.location_id = locations.id
        inner join trends on trend_data.trend_id = trends.id'
      ]
    )

    trend_info.each do |trend_data|
      trend_data_point = TrendingData.new(trend_data.x, trend_data.y, trend_data.name)
      unless trend_data_point.nil?
        trending_data.push trend_data_point
      end
    end
    trending_data.to_json
  end
end
