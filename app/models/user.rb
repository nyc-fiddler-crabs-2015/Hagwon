class User < ActiveRecord::Base
	has_secure_password
	validates_uniqueness_of :username
	validates_uniqueness_of :email
	has_many :reviews
	has_many :tracks
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
end
