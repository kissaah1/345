class Position < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(start_date: :desc) }
  validates :user_id, presence: true
  validates :summary, length: { maximum: 140 }
end
