class Employment < ActiveRecord::Base
	belongs_to :user
	belongs_to :company
	validates :user_id, presence: true
end
