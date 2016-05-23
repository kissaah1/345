require 'test_helper'

class EmploymentTest < ActiveSupport::TestCase

	def setup
		@user = users(:masaaki)
		@employment = @user.employments.build(senior: "t")
	end

	test "should be valid" do
		assert @employment.valid?
	end

	test "user id should be present" do
		@employment.user_id = nil
		assert_not @employment.valid?
	end

	test "company id should be present" do
		@employment.company_id = nil
		assert @employment.valid?
	end


end
