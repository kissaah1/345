class Survey < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :question_1, presence: true, length: { maximum: 140 }
  validates :question_2, presence: true, length: { maximum: 140 }
  validates :question_3, presence: true, length: { maximum: 140 }
  validates :question_4, presence: true, length: { maximum: 140 }
  validates :question_5, presence: true, length: { maximum: 140 }
  validates :question_6, presence: true, length: { maximum: 140 }
  validates :question_7, presence: true, length: { maximum: 140 }
  validates :question_8, presence: true, length: { maximum: 140 }
  validates :question_9, presence: true, length: { maximum: 140 }
  validates :question_10, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }

end
