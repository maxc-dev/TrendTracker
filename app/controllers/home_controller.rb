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

    TrendDatum.all.each do |trend_data|
      location = Location.from_id(trend_data.location_id).first
      trend = Trend.from_id(trend_data.trend_id).first
      trend_data_point = TrendingData.new(location.x, location.y, trend.name)
      unless trend_data_point.nil?
        @all_trend_data.push trend_data_point
      end
    end

    @all_trend_data = @all_trend_data.to_json

  end
end
