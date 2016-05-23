class AddCadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cadmin, :boolean, default: false
  end
end
