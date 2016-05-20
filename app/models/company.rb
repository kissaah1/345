class Company < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :name, presence: true
	validates :industry, presence: true
	VALID_URI_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
	validates :website, presence: true, length: { maximum: 50 },
	format: { with: VALID_URI_REGEX }
	validates :summary, presence: true, length: { maximum: 140 }


end
