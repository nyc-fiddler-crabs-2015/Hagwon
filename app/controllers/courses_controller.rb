class CoursesController < ApplicationController

  def sort_courses(track)
    order_array = Track.find(params[:track_id]).order.split(",").to_a.map{|x| x.to_i}
    return track.courses.includes(:reviews).find(order_array).index_by(&:id).values_at(*order_array)
  end


  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    course_ids = UserCourse.where(user_id: session[:user_id]).map{|course| course.course_id}
    course_ids = [-1] if course_ids.length == 0
    render json: {courses: sort_courses(track).to_json(:include => :reviews), userCourses: course_ids}
  end


  def check
    info = {user_id: session[:user_id], course_id: params[:course_id]}
    if UserCourse.find_by(info) == nil
      UserCourse.create(info)
    end
    redirect_to :back
  end

  def uncheck
    subscription = UserCourse.find_by(user_id: session[:user_id], course_id: params[:course_id])
    if subscription
      subscription.destroy
      subscription.save
    end
    redirect_to :back
  end

  def destroy
  end

end
