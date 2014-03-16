require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "boolean should be true" do
    assert true
  end

  test "should be valid" do
    u = User.new
    assert u.valid?
  end

end
