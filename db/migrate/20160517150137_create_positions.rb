class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.text :summary
      t.date :start_date
      t.date :end_date
      t.boolean :is_current
      t.string :company
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :positions, [:user_id, :created_at]
  end
end
