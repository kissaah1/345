require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test  "layout links" do
  	assert_template 'welcome/index'
  	assert_select "a[href=?]", about_path
  end
end
