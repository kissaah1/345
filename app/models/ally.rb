class Ally < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order(created_at: :asc) }
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40 }
	validates :descriptions, presence: true, length: { maximum: 400 }
end
