require 'test_helper'

class PartTest < ActiveSupport::TestCase
  # test valid part creation
  test 'test valid part' do
    part = Part.new
    part.category_id = categories(:cpu).id
    part.manufacturer_id = manufacturers(:nvidia).id
    part.name = 'Item Name'
    part.price = 999.99
    part.power = 99

    part.save
    assert part.valid?
  end

  # test invalid part creation
  test 'test invalid part no name' do
    part = Part.new
    part.category_id = categories(:cpu).id
    part.manufacturer_id = manufacturers(:nvidia).id
    part.price = 999.99
    part.power = 99

    part.save
    refute part.valid?
  end

  # test invalid part creation 2
  test 'test invalid part invalid price' do
    part = Part.new
    part.category_id = categories(:cpu).id
    part.manufacturer_id = manufacturers(:nvidia).id
    part.name = 'Item Name'
    part.price = 0
    part.power = 99

    part.save
    refute part.valid?
  end

  # test invalid part creation 3
  test 'test invalid part invalid category' do
    part = Part.new
    part.category_id = 0
    part.manufacturer_id = manufacturers(:nvidia).id
    part.name = 'Item Name'
    part.price = 999.99
    part.power = 99

    part.save
    refute part.valid?
  end

  # test invalid part creation 4
  test 'test invalid part invalid manufacturer' do
    part = Part.new
    part.category_id = categories(:cpu).id
    part.manufacturer_id = 0
    part.name = 'Item Name'
    part.price = 999.99
    part.power = 99

    part.save
    refute part.valid?
  end
end
