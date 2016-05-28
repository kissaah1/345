class AddLinkedinImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_image, :string
  end
end
