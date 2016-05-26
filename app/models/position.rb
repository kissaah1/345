class Position < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order(start_date: :desc) }
	mount_uploader :picture, PictureUploader
	validates :user_id, presence: true
	validates :summary, length: { maximum: 140 }
	validates :title, length: { maximum: 50 }
	validates :company, length: { maximum: 50 }
  	validate  :picture_size

    private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
