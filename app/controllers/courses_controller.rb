class CoursesController < ApplicationController

  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    order_array = Track.find(params[:track_id]).order.split(",").to_a.map{|x| x.to_i}
    courses = track.courses.find(order_array).index_by(&:id).values_at(*order_array)
    render json: courses.to_json(:include => :reviews)
  end

end

