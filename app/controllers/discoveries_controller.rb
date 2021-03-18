class DiscoveriesController < ApplicationController

  def index
    trend_info = TrendDatum.find_by_sql([
      'select locations.country as country, locations.name as city, trends.name as name, trends.id as tre_id, locations.id as loc_id from trend_data
      inner join locations on trend_data.location_id = locations.id
      inner join trends on trend_data.trend_id = trends.id order by locations.country'
    ])

    @all_trend_data = []

    trend_info.each do |trend_data|
      @all_trend_data.push [trend_data.country, trend_data.city, trend_data.name]
    end

  end

end
