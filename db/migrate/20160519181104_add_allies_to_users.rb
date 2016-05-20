class AddAlliesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :enthusiast, :boolean, default: false
    add_column :users, :skeptic, :boolean, default: false
    add_column :users, :navigator, :boolean, default: false
    add_column :users, :pioneer, :boolean, default: false
    add_column :users, :coach, :boolean, default: false
    add_column :users, :solo, :boolean, default: true
  end
end
