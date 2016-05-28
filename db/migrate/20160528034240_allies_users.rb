class AlliesUsers < ActiveRecord::Migration
  def change
  	create_table :allies_users, :id => false do |t|
  		t.integer :ally_id
  		t.integer :user_id
  	end
  end
end
