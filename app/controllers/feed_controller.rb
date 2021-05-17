class FeedController < ApplicationController
  class LocalTrendData
    attr_accessor :country, :city, :trend

    def initialize(country, city, trend)
      @country = country
      @city = city
      @trend = trend
    end
  end

  def index
    @top_trends = []
    @trends = []

    if current_user.present?
      user_privacy = UserPrivacy.user_agreement(current_user.id)
      if user_privacy.present?
        row = user_privacy.first
        crypt = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPTION_KEY'])
        latitude = crypt.decrypt_and_verify(row.latitude)
        longitude = crypt.decrypt_and_verify(row.longitude)

        @trends = get_trends_within_bound(latitude, longitude, 5)
      end
    end
  end

  # gets the most popular trends by occurrence
  def get_top_trends
    trend_info = TrendDatum.find_by_sql(
      [
        'select locations.name as city, locations.country as country,
        trends.name as name, count(trend_data.trend_id) as value_occurrence from trend_data
        inner join locations on trend_data.location_id = locations.id
        inner join trends on trend_data.trend_id = trends.id
        group by trend_data.trend_id order by value_occurrence desc limit 20'
      ]
    )

    trending_data = []
    trend_info.each do |trend_data|
      trend_data_point = LocalTrendData.new(trend_data.country, trend_data.city, trend_data.name)
      unless trend_data_point.nil?
        trending_data.push trend_data_point
      end
    end
    trending_data
  end

  # gets trends within a certain bound of some coordinates
  def get_trends_within_bound(latitude, longitude, bound)
    # calculate upper/lower coordinate bounds for lat/long
    low_lat = latitude - bound
    high_lat = latitude + bound
    low_long = longitude - bound
    high_long = longitude + bound

    # custom sql to get trends within the bounds
    trend_info = TrendDatum.find_by_sql(
      [
        'select locations.name as city, locations.country as country,
        trends.name as name from trend_data
        inner join locations on trend_data.location_id = locations.id
        inner join trends on trend_data.trend_id = trends.id
        where locations.x > ? and locations.x < ? and
        locations.y > ? and locations.y < ? limit 10',
        low_lat, high_lat, low_long, high_long
      ]
    )

    # send all trend data to an object list then return the list
    trending_data = []
    trend_info.each do |trend_data|
      trend_data_point = LocalTrendData.new(trend_data.country, trend_data.city, trend_data.name)
      unless trend_data_point.nil?
        trending_data.push trend_data_point
      end
    end
    trending_data
  end
end
