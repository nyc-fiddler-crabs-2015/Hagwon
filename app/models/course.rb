class Course < ActiveRecord::Base
  has_many :course_tracks
  has_many :tracks, through: :course_tracks
  belongs_to :category

  def rating
  end

end
