require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

	def setup
		@user = users(:masaaki)
		# This code is not idiomatically correct.
		@company = @user.companies.build(name: "Awesome Inc.", industry: "Internet", website: "http://www.hugehood.co",
		summary: "HUGEHOOD is a digital consultancy that helps leaders to build a startup and brand that drives 
		long-term impact for the better.")
	end

	test "should be valid" do
		assert @company.valid?
	end

	test "user id should be present" do
		@company.user_id = nil
		assert_not @company.valid?
	end

	test "summary should be present" do
		@company.summary = "	 "
		assert_not @company.valid?
	end

	test "summary should be at most 140 characters" do
		@company.summary = "a" * 141
		assert_not @company.valid?
	end

	test "order should be most recent first" do
		assert_equal companies(:most_recent), Company.first
	end

	test "website should be present" do
		@company.website = " "
		assert_not @company.valid?
	end

	test "website should not be too long" do
		@company.website = "http://" + "a" * 50 + ".com"
		assert_not @company.valid?
	end

	test "website should be valid" do
		@company.website = "don://" + "dkou@.co"
		assert_not @company.valid?
	end


end
