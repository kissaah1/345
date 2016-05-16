class AddSurveyToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :survey_1, :text
    add_column :microposts, :survey_2, :text
    add_column :microposts, :survey_3, :text
  end
end
