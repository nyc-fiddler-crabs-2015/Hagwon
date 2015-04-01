class TracksController < ApplicationController

  def index
  end

  def json
    @tracks = Track.includes(:owner, :category).where(parent_id: nil)
    render json: @tracks.to_json(:include => { :owner => { :only => :username }, category: {only: :name} })
  end

  def show
    @count  = Track.find(params[:id]).popularity
    @track  = Track.includes(:owner, :users).find(params[:id])
    @owner = Track.find(@track.parent_id).owner if @track.parent_id
    @review = Review.new
  end


  def cat
    Category.includes(:courses => [:reviews, :platform]).find(params[:category_id])
  end


  def new
    @category = cat
    @courses  = cat.courses.includes(:reviews, :platform).all
  end

  def new_json
    render json: {category: cat, courses: cat.courses.to_json(:include => [:reviews, :platform])}
  end


  def create
    user          = User.find(session[:user_id])
    track         = user.tracks.new(track_params)
    track.user_id = session[:user_id]
    array_of_ids  = params[:order].split(",").to_a.map{|i| i.to_i}
    track.courses = Course.find(array_of_ids)
    track.save
    UserTrack.create(track: track, user_id: session[:user_id])
    redirect_to track
  end


  def edit
    user   = User.find(session[:user_id])
    @track = Track.includes(:courses, :category => :courses).find(params[:id])
    @checked_courses = @track.courses
    hey = @checked_courses.map{|x| x.id}
    @all_courses     = @track.category.courses.where.not(id: hey) - @checked_courses
    unless user.tracks.include?(@track)
      redirect_to @track
    end
  end

  def edit_json
    render json: {courses: @all_courses, checked: @checked_courses}
  end

  def update
    track = Track.find(params[:id])
    track.update_attributes(name: params[:title], order: params[:order])
    courses       = params[:order].split(",").to_a.map{|value, key| value.to_i }
    track.courses = Course.find(courses)
    track.save
    redirect_to track
  end

  def fork
    if current_user.tracks.find_by(id: params[:track_id])== nil
      track = Track.includes(:courses).find(params[:track_id])
      new_track           = track.dup
      new_track.courses   = track.courses
      new_track.owner = current_user
      new_track.parent_id = track.id
      new_track.save
      track.popularity   +=1
      track.save
      UserTrack.create(user: current_user, track: new_track)
      redirect_to edit_track_path(new_track.id)
    else
      flash[:forked] = "You already forked this"
      redirect_to :back
    end

  end

  def follow
    if current_user.tracks.find_by(id: params[:track_id]) == nil
      track = UserTrack.create(user_id: session[:user_id], track_id: params[:track_id])
      redirect_to track
    else
      flash[:forked] = "You already followed this Course"
      redirect_to :back
    end
  end

  private
  def track_params
    params.permit(:category_id, :name, :order, :description)
  end



end