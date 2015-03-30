class CoursesController < ApplicationController

  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    order_array = Track.find(params[:track_id]).order.split(",").to_a.map{|x| x.to_i}
    courses = track.courses.find(order_array).index_by(&:id).values_at(*order_array)
    hey = UserCourse.where(user_id: session[:user_id]).map{|course| course.course_id}
    user_courses = hey if hey.length > 0
    render json: {courses: courses.to_json(:include => :reviews), userCourses: user_courses || [-1] }
  end

  #User has many courses through UserCourses
  #A course has many users through UserCourses

  def check
    UserCourse.create(user_id: session[:user_id], course_id: params[:course_id])
    redirect_to :back
  end

  def uncheck
    course = UserCourse.find_by(user_id: session[:user_id], course_id: params[:course_id])
    course.destroy if course
    course.save
    redirect_to :back
  end

  def destroy
  end

end
