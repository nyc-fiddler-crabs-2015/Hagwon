class Track < ActiveRecord::Base
  belongs_to :category
  has_many :course_tracks
  has_many :courses, through: :course_tracks
  has_many :user_tracks
  has_many :users, through: :user_tracks
end
