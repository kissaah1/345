class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.boolean :senior
      t.boolean :manager
      t.boolean :staff
      t.references :user, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :employments, [:user_id, :created_at]
    add_index :employments, [:company_id, :created_at]
  end
end
