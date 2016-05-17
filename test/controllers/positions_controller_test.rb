require 'test_helper'

class PositionsControllerTest < ActionController::TestCase

  def setup
    @position = positions(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Position.count' do
      post :create, position: { title: "Cptain EO", summary: "yabadaba yabadaba!", start_date: "2005/12/01",
    	end_date: "2015/01/01", is_current: false, company: "Awesome Inc." }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Position.count' do
      delete :destroy, id: @position
    end
    assert_redirected_to login_url
  end

end
