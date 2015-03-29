class TracksController < ApplicationController
  def index
  end

  def show
    @count = Track.find(params[:id]).users.count
    @track = Track.includes(:owner).find(params[:id])
  end

  def json
    @tracks = Track.includes(:owner, :category).all
    render json: @tracks.to_json(:include => { :owner => { :only => :username }, category: {only: :name} })
  end

  def new
    @category = Category.find(params[:category_id])
    @courses = @category.courses
  end

  def create
    track = Track.create(user_id: session[:user_id], category_id: params[:category_id], name: params[:title])
    x = 0
    params[:course].each do |value, key|
      course = Course.find(key.to_i)
      CourseTrack.create(order: 1, track: track, course: course)
    end
    redirect_to track
  end

  def edit
  end

  #forking >
  # new_track = Track.includes(:courses).find("track_id").dup
  # UserTrack.create(user_id: session[:user_id], track_id: new_track), after that User.find(session[:user_id]).tracks will include the newly forked track
  # User.find(session[:user_id]).tracks.find(11).courses.delete(20), deletes a course from a duplicated track without affecting neither the course nor the original track themselves.

  def fork
    forked = Track.find(params[:track_id])
    track         = forked.dup
    track.courses = forked.courses.dup
    track.save
    UserTrack.create(user_id: session[:user_id], track: track)
    redirect_to tracks_path
  end


end