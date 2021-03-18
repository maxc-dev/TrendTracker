class HomeController < ApplicationController
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

  def home
    @all_trend_data = []

    trend_info = TrendDatum.find_by_sql([
      'select locations.x as x, locations.y as y, trends.name as name from trend_data
      inner join locations on trend_data.location_id = locations.id
      inner join trends on trend_data.trend_id = trends.id'
    ])

    trend_info.each do |trend_data|
      trend_data_point = TrendingData.new(trend_data.x, trend_data.y, trend_data.name)
      unless trend_data_point.nil?
        @all_trend_data.push trend_data_point
      end
    end

    @all_trend_data = @all_trend_data.to_json
  end
end
