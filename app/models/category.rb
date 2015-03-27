class Category < ActiveRecord::Base
  has_many :courses
  has_many :tracks
end
