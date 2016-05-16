class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :question_1
      t.text :question_2
      t.text :question_3
      t.text :question_4
      t.text :question_5
      t.text :question_6
      t.text :question_7
      t.text :question_8
      t.text :question_9
      t.text :question_10
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :surveys, [:user_id, :created_at]
  end
end
