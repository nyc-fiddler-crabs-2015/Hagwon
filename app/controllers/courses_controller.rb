class CoursesController < ApplicationController

  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    courses = track.courses.includes(:reviews)
    render json: track.courses.to_json(:include => :reviews)
  end

end

