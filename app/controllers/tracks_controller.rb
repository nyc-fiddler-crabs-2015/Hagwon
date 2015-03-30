class TracksController < ApplicationController
  def index
  end

  def show
    owner  = Track.find(params[:id]).owner.id
    @count = Track.where(owner: owner).count
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
    track = Track.create(user_id: session[:user_id], category_id: params[:category_id], name: params[:title], order: params[:position])
    params[:course].each do |value, key|
      course = Course.find(key.to_i)
      CourseTrack.create(track: track, course: course)
    end
    UserTrack.create(track: track, user_id: session[:user_id])
    redirect_to track
  end

  def edit
    @track = Track.includes(:courses, :category => :courses).find(params[:id])
    @checked_courses = @track.courses
    @all_courses = @track.category.courses - @checked_courses
    if session[:user_id] != @track.user_id
      redirect_to @track
    end
  end

  def update
    track = Track.find(params[:id])
    track.update(name: params[:title]) if params[:title].length > 2
    courses = params[:course].map{|value, key| value.to_i }
    track.courses = Course.find(courses)
    track.save
    redirect_to track
  end

  def fork
    forked = Track.includes(:courses).find(params[:track_id])
    track         = forked.dup
    track.courses = forked.courses.dup
    track.save
    UserTrack.create(user_id: session[:user_id], track: track)
    redirect_to tracks_path
  end


end