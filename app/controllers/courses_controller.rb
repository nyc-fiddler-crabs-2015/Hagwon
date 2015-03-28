class CoursesController < ApplicationController
  def index
    track = Track.find(params[:track_id])
    render json: track.courses
  end


end
