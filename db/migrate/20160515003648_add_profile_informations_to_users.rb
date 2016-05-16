class AddProfileInformationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :industry, :string
    add_column :users, :headline, :string
    add_column :users, :linkedin, :string
    add_column :users, :summary, :text
    add_column :users, :skills, :text
    add_column :users, :other_skills, :text
  end
end
