class Ally < ActiveRecord::Base
	has_and_belongs_to_many :user, join_table: :allies_users
	default_scope -> { order(created_at: :asc) }
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40 }
	validates :descriptions, presence: true, length: { maximum: 400 }
end
