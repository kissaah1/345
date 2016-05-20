class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.string :website
      t.text :summary
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :companies, [:user_id, :created_at]
  end
end
