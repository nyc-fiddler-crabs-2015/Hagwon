class TracksController < ApplicationController
  def index
  end

  def show
    @count  = Track.find(params[:id]).popularity
    @track  = Track.includes(:owner).find(params[:id])
  end

  def json
    @tracks = Track.includes(:owner, :category).where(parent_id: nil)
    render json: @tracks.to_json(:include => { :owner => { :only => :username }, category: {only: :name} })
  end

  def new
    @category = Category.find(params[:category_id])
    @courses  = @category.courses
  end

  def create
    track_id = params[:track_id] || nil
    track    = Track.create(user_id: session[:user_id], category_id: params[:category_id], name: params[:title], order: params[:position])
    array_of_ids  = params[:course].map{|x,y| x.to_i}
    track.courses = Course.find(array_of_ids)
    track.save
    UserTrack.create(track: track, user_id: session[:user_id])
    redirect_to track
  end

  def edit
    user   = User.find(session[:user_id])
    @track = Track.includes(:courses, :category => :courses).find(params[:id])
    @checked_courses = @track.courses
    @all_courses     = @track.category.courses - @checked_courses
    unless user.tracks.include?(@track)
      redirect_to @track
    end
  end

  def update
    track = Track.find(params[:id])
    track.update_attributes(name: params[:title], order: params[:position])
    courses = params[:course].map{|value, key| value.to_i }
    track.courses = Course.find(courses)
    track.save
    redirect_to track
  end

  def follow
    if current_user.tracks.find_by(id: params[:track_id])== nil
      track = Track.includes(:courses).find(params[:track_id])
      new_track           = track.dup
      new_track.courses   = track.courses
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


end