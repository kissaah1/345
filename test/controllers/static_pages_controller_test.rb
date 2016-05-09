require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Employee Success 345 Thrive"
  end

  test "should get terms" do
    get :terms
    assert_response :success
    assert_select "title", "Terms | Employee Success 345 Thrive"
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
    assert_select "title", "Privacy | Employee Success 345 Thrive"
  end

end
