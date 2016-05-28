class CreateAllies < ActiveRecord::Migration
  def change
    create_table :allies do |t|
      t.string :name
      t.text :descriptions
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :allies, [:user_id, :created_at]
  end
end
