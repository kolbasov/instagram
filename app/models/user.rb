class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, 	presence: true, uniqueness: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX }

	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy

	has_secure_password  
	validates :password, presence: true, length: { minimum: 6 }

	attr_accessor :remember_token

	def to_param
  	name
	end

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(self.remember_token))
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end
end