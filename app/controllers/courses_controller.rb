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
    subscription = UserCourse.find_by(user_id: session[:user_id], course_id: params[:course_id])
    if subscription
      subscription.destroy
      subscription.save
    else
      UserCourse.create(user_id: sesssion[:user_id], course_id: params[:course_id])
    end
    render json: 'I dont want to be redirected'
  end

  def destroy
  end

end
