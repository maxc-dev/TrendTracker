require 'test_helper'

class TrendTest < ActiveSupport::TestCase
  # test valid trend creation
  test 'test valid trend' do
    trend = Trend.new
    trend.name = 'test trend'
    trend.save
    assert trend.valid?
  end

  # test invalid trend creation
  test 'test invalid trend no name' do
    trend = Trend.new
    trend.name = nil
    trend.save
    refute trend.valid?
  end

  # test unique trend
  test 'test unique trend' do
    trend = Trend.new
    trend.name = 'trend one'
    trend.save

    trend2 = Trend.new
    trend2.name = 'trend one'
    trend2.save
    refute trend2.valid?
  end

end
