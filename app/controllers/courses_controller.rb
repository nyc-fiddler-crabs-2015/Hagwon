class CoursesController < ApplicationController

  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    render json: track.courses.to_json(:include => :reviews)
  end

end

