require 'test_helper'

class TrendDatumTest < ActiveSupport::TestCase
  test "create valid trend location pairing" do
    pairing = TrendDatum.new
    pairing.location = locations(:gb)
    pairing.trend = trends(:one)
    pairing.save
    assert pairing.valid?
  end

  test "validate unique location" do
    pairing = TrendDatum.new
    pairing.location = locations(:gb)
    pairing.trend = trends(:one)
    pairing.save

    pairing2 = TrendDatum.new
    pairing2.location = locations(:gb)
    pairing2.trend = trends(:one)
    pairing2.save
    refute pairing2.valid?
  end

  test "validate non unique trend" do
    pairing = TrendDatum.new
    pairing.location = locations(:gb)
    pairing.trend = trends(:one)
    pairing.save

    pairing2 = TrendDatum.new
    pairing2.location = locations(:mx)
    pairing2.trend = trends(:one)
    pairing2.save
    assert pairing2.valid?
  end
end
