class Course < ActiveRecord::Base
  has_many :course_tracks
  has_many :reviews
  has_many :tracks, through: :course_tracks
  belongs_to :category

  def rating
    ratings = Review.where(course_id: self.id).map { |rev| rev.rating  }
    average = ratings.reduce(:+).to_f / ratings.size
  end

  def difficulty
    difficulties = Review.where(course_id: self.id).map { |rev| rev.difficulty  }
    average = difficulties.reduce(:+).to_f / ratings.size
  end

end
