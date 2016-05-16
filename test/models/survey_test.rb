require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:masaaki)
    @survey = @user.surveys.build(question1: "Most likely")
    @survey = @user.surveys.build(question2: "Most likely")
    @survey = @user.surveys.build(question3: "Most likely")
    @survey = @user.surveys.build(question4: "Most likely")
    @survey = @user.surveys.build(question5: "Most likely")
    @survey = @user.surveys.build(question6: "Most likely")
    @survey = @user.surveys.build(question7: "Most likely")
    @survey = @user.surveys.build(question8: "Most likely")
    @survey = @user.surveys.build(question9: "Most likely")
    @survey = @user.surveys.build(question10: "Most likely")
  end

#  test "should be valid" do
#    assert @survey.valid?
#  end

  test "user id should be present" do
    @survey.user_id = nil
    assert_not @survey.valid?
  end

  test "question1 should be present" do
    @survey.question1 = "   "
    assert_not @survey.valid?
  end

  test "question1 should be at most 140 characters" do
    @survey.question1 = "a" * 141
    assert_not @survey.valid?
  end

  test "question2 should be present" do
    @survey.question2 = "   "
    assert_not @survey.valid?
  end

  test "question2 should be at most 140 characters" do
    @survey.question2 = "a" * 141
    assert_not @survey.valid?
  end

  test "question3 should be present" do
    @survey.question3 = "   "
    assert_not @survey.valid?
  end

  test "question3 should be at most 140 characters" do
    @survey.question3 = "a" * 141
    assert_not @survey.valid?
  end

  test "question4 should be present" do
    @survey.question4 = "   "
    assert_not @survey.valid?
  end

  test "question4 should be at most 140 characters" do
    @survey.question4 = "a" * 141
    assert_not @survey.valid?
  end

  test "question5 should be present" do
    @survey.question5 = "   "
    assert_not @survey.valid?
  end

  test "question5 should be at most 140 characters" do
    @survey.question5 = "a" * 141
    assert_not @survey.valid?
  end

  test "question6 should be present" do
    @survey.question6 = "   "
    assert_not @survey.valid?
  end

  test "question6 should be at most 140 characters" do
    @survey.question6 = "a" * 141
    assert_not @survey.valid?
  end

  test "question7 should be present" do
    @survey.question7 = "   "
    assert_not @survey.valid?
  end

  test "question7 should be at most 140 characters" do
    @survey.question7 = "a" * 141
    assert_not @survey.valid?
  end

  test "question8 should be present" do
    @survey.question8 = "   "
    assert_not @survey.valid?
  end

  test "question8 should be at most 140 characters" do
    @survey.question8 = "a" * 141
    assert_not @survey.valid?
  end

  test "question9 should be present" do
    @survey.question9 = "   "
    assert_not @survey.valid?
  end

  test "question9 should be at most 140 characters" do
    @survey.question9 = "a" * 141
    assert_not @survey.valid?
  end

  test "question10 should be present" do
    @survey.question10 = "   "
    assert_not @survey.valid?
  end

  test "question10 should be at most 140 characters" do
    @survey.question10 = "a" * 141
    assert_not @survey.valid?
  end

end
