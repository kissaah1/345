class User < ActiveRecord::Base
#	include PgSearch
#	pg_search_scope :search, :against => [:name, :email]
	mount_uploader :picture, PictureUploader
	has_and_belongs_to_many :allies, join_table: :allies_users, dependent: :destroy
	has_many :employments, dependent: :destroy
	has_many :companies, dependent: :destroy
	has_many :positions, dependent: :destroy
	has_many :microposts, dependent: :destroy
	has_many :active_relationships, class_name:	"Relationship",
	foreign_key: "follower_id",	dependent:	 :destroy
	has_many :passive_relationships, class_name:	"Relationship",
	foreign_key: "followed_id",	dependent:	 :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email
	before_create :create_activation_digest
	validates :summary, length: { maximum: 800 }
	validates :name, length: { maximum: 50 }
	# validates :picture, presence: true
	# validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	# Returns the hash digest of the given string.
	validate	:picture_size

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def self.from_omniauth(auth)
		# where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.name = auth["info"]["name"]
			user.email = auth["info"]["email"]
			user.password = SecureRandom.urlsafe_base64 unless user.password != nil
			user.activated = true
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.location = auth["info"]["location"]
			user.industry = auth["info"]["industry"]
			user.headline = auth["info"]["headline"]
			user.linkedin = auth["info"]["urls"]["public_profile"]
			user.linkedin_image = auth["info"]["image"]
			user.save!
		end
	end

	# Returns a romdam token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgot a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Activates an account.
	def activate
		update_attribute(:activated, true)
		update_attribute(:activated_at, Time.zone.now)
	end

	# Sends activation email.
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	# Sets the password reset attributes.
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest,	User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	def self.search(query)
		if query.present?
			rank = <<-RANK
			ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(email), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(location), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(industry), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(headline), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(summary), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(skills), plainto_tsquery(#{sanitize(query)})) +
			ts_rank(to_tsvector(other_skills), plainto_tsquery(#{sanitize(query)}))
			RANK
			where("name @@ :q	or email @@ :q	or location @@ :q	or industry @@ :q	or headline @@ :q	or summary @@ :q or skills @@ :q or other_skills @@ :q", q: query).order("#{rank} desc")
		end
	end

#	def self.search(query)
#		if query.present?
#			search(query)
#		else
#			scoped
#		end
#	end


	# Defines a proto-feed.
	# See "Following users" for the full implementation.
	def feed
		following_ids = "SELECT followed_id FROM relationships
		WHERE	follower_id = :user_id"
		Micropost.where("user_id IN (#{following_ids})
			OR user_id = :user_id", user_id: id)
	end

	# Follows a user.
	def follow(other_user)
		active_relationships.create(followed_id: other_user.id)
	end

	# Unfollows a user.
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	# Returns true if the current user is following the other user.
	def following?(other_user)
		following.include?(other_user)
	end

	private

		# Converts email to all lower-case.
		def downcase_email
				self.email = email.downcase
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
				self.activation_token = User.new_token
				self.activation_digest = User.digest(activation_token)
		end

		# Validates the size of an uploaded picture.
		def picture_size
			if picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end


end
