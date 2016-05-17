require 'test_helper'

class PositionTest < ActiveSupport::TestCase

  def setup
    @user = users(:masaaki)
    # This code is not idiomatically correct.
    @position = @user.positions.build(title: "Cptain EO", summary: "yabadaba yabadaba!", start_date: "2005/12/01",
    	end_date: "2015/01/01", is_current: false, company: "Awesome Inc.")
  end

  test "should be valid" do
    assert @position.valid?
  end

  test "user id should be present" do
    @position.user_id = nil
    assert_not @position.valid?
  end

#  test "summary should be present" do
#    @position.summary = "   "
#    assert_not @position.valid?
#  end

  test "position should be at most 140 characters" do
    @position.summary = "a" * 141
    assert_not @position.valid?
  end

  test "order should be most recent first" do
    assert_equal positions(:most_recent), Position.first
  end

end
