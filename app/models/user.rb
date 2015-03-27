class User < ActiveRecord::Base
	has_secure_password
	validates_uniqueness_of :user_name
	validates_uniqueness_of :email
	has_many :reviews
	has_many :tracks
end
