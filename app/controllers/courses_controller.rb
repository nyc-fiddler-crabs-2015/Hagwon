class CoursesController < ApplicationController

  # This hurts my eyes
  def index
    track = Track.includes(:courses => :reviews).find(params[:track_id])
    order_array = Track.find(params[:track_id]).order.split(",").to_a.map{|x| x.to_i}
    courses = track.courses.find(order_array).index_by(&:id).values_at(*order_array)
    hey = UserCourse.where(user_id: session[:user_id]).map{|course| course.course_id}
    user_courses = hey if hey.length > 0
    render json: {courses: courses.to_json(:include => :reviews), userCourses: user_courses || [-1] }
  end

  def check
    # I think your join table has a bad name. I think there's  abetter noun
    # that describes the relationship between a course and a user, namely a
    # Registration.  This table could be called registrations and then we would
    # be able to meaningfully infer what the purpose of a `Registration` model
    # is.  As is, you have foollowed the naming convetion for join tables and
    # that, as a result, means that you are stuck with Rails' bon-headed naming
    # conventions.  This does not make your code as clear as it could be.
    #
    # Well, whatever your logic on why this is here or what it should be named,
    # I'm not entirely clear what a UserCourse is from the name of the model

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
    # Seems odd that you're doig destroy on uncheck, you have something that's
    # kind of REST-ful, but you're not really doing RESTful things
  end

end
