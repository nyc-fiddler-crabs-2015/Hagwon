class CoursesController < ApplicationController

  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    order_array = Track.find(params[:track_id]).order.split(",").to_a.map{|x| x.to_i}
    courses = track.courses.find(order_array).index_by(&:id).values_at(*order_array)
    render json: {courses: courses.to_json(:include => :reviews), userCourses: UserCourse.where(user_id: session[:user_id]) }
    # CourseTrack.where(track_id: params[:track_id]).sort_by(:order)
  end

  #User has many courses through UserCourses
  #A course has many users through UserCourses

  def check
    UserCourse.create(user_id: user_id, course_id: params[:id])
  end

  def destroy
  end

end
