class Track < ActiveRecord::Base
  belongs_to :owner, class_name: "User",
                        foreign_key: "user_id"
  belongs_to :category
  has_many :course_tracks
  has_many :courses, through: :course_tracks
  has_many :user_tracks
  has_many :users, through: :user_tracks

  # Sorry, I couldn't figure this out, but it should go here ;)
  #
  # But I'm sure YOU will figure it out, Rayan B.
  def to_json(options = {})
    super
  end
end
