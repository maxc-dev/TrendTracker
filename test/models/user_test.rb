require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # tests that an invalid user is not saved
  test 'refute invalid user save' do
    user = User.new
    user.save
    refute user.valid?
  end

  # tests that a valid user gets saved
  test 'saves valid user' do
    user = User.new
    user.email = 'random@example.com'
    user.password = '123456'
    user.save
    assert user.valid?
  end

  # tests that a password is 6 chars or longer
  test 'refute invalid user password' do
    user = User.new
    user.email = 'random@example.com'
    user.password = '12345'
    user.save
    refute user.valid?
  end

  # tests that a user matches the fixtures
  test 'assert equal user fixture' do
    user = User.new
    user.email = 'one@example.com'
    user.password = 'nothing'
    user.save
    assert_equal user.email, users(:one).email
  end
end
