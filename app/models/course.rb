class Course < ActiveRecord::Base
  has_many :course_tracks
  has_many :reviews
  has_many :tracks, through: :course_tracks
  has_many :user_courses
  has_many :users, through: :user_courses
  belongs_to :category

  def rating
    # Beware n+1 query here!
    ratings = Review.includes(:course).where(course_id: self.id).map { |rev| rev.rating  }
    average = ratings.reduce(:+).to_f / ratings.size
  end

  def difficulty
    difficulties = Review.where(course_id: self.id).map { |rev| rev.difficulty  }
    average = difficulties.reduce(:+).to_f / ratings.size
  end

end
