require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  # test valid creation of a manufacturer
  test "valid manufacturer create" do
    manu = Manufacturer.new
    manu.name = 'Gigabyte'

    manu.save
    assert manu.valid?
  end

  # test valid creation of a manufacturer to fixture
  test "valid manufacturer fixture" do
    manu = Manufacturer.new
    manu.name = 'NVIDIA'

    manu.save
    assert_equal manu.name, manufacturers(:nvidia).name
  end

  # test no duplicate manufacturer name
  test "no duplicate manufacturer names" do
    manu1 = Manufacturer.new
    manu1.name = 'Razer'
    manu1.save
    assert manu1.valid?

    manu2 = Manufacturer.new
    manu2.name = 'Razer'
    manu2.save
    refute manu2.valid?
  end

  # test valid name
  test "valid manufacturer name" do
    manu = Manufacturer.new
    manu.name = ''
    manu.save
    refute manu.valid?
  end
end
