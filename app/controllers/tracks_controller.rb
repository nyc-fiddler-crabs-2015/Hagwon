class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
    @count = @track.users.count
    @user = @track.owner
  end

  def json
    render json: Track.all.to_json(:include => { :owner => { :only => :username }, category: {only: :name} })
  end

  def new
    @category = Category.find(params[:category_id])
    @courses = @category.courses
  end

  def create
    track = Track.create(user_id: 2, category_id: params[:category_id], name: params[:title])
    x = 0
    params[:course].each do |value, key|
      course = Course.find(key.to_i)
      CourseTrack.create(order: 1, track: track, course: course)
    end
    redirect_to track
  end

  #forking >
  # new_track = Track.includes(:courses).find("track_id").dup
  # UserTrack.create(user_id: session[:user_id], track_id: new_track), after that User.find(session[:user_id]).tracks will include the newly forked track
  # User.find(session[:user_id]).tracks.find(11).courses.delete(20), deletes a course from a duplicated track without affecting neither the course nor the original track themselves.

  def fork
    track = Track.find(params[:track_id]).dup
    track.courses = Track.find(params[:track_id]).courses.dup
    user_id = session[:user_id]
    UserTrack.create(user_id: user_id, track: track)
    redirect_to tracks_path
  end


end