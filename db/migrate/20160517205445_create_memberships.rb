class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :type
      t.references :users, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
