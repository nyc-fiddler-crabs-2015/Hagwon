class Track < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :course_tracks
  has_many :courses, through: :course_tracks
end
