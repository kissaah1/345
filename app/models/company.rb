class Company < ActiveRecord::Base
	belongs_to :user
	has_many :employments
	default_scope -> { order(created_at: :desc) }
	mount_uploader :picture, PictureUploader
	validates :user_id, presence: true
	validates :name, presence: true
	validates :industry, presence: true
	VALID_URI_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
	validates :website, presence: true, length: { maximum: 50 },
	format: { with: VALID_URI_REGEX }
	validates :summary, presence: true, length: { maximum: 140 }
	validate  :picture_size


	def self.search(query)
		if query.present?
			rank = <<-RANK
			ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(industry), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(summary), plainto_tsquery(#{sanitize(query)}))
			RANK
			where("name @@ :q or industry @@ :q or summary @@ :q", q: query).order("#{rank} desc")
		end
	end

    private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
