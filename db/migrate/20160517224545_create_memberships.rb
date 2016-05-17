class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :memberships, [:user_id, :created_at]
    add_index :memberships, [:group_id, :created_at]
  end
end
