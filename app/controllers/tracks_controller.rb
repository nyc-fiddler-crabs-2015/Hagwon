class TracksController < ApplicationController
  def index
  end

  def show
    @count  = Track.find(params[:id]).users.count
    @track = Track.includes(:owner).find(params[:id])
  end

  def json
    @tracks = Track.includes(:owner, :category).all
    # I feel like we can buy this inside of the Track class
    render json: @tracks.to_json
  end

  def new
    @category = Category.find(params[:category_id])
    @courses = @category.courses
  end

  def create
    # Cleaner, uses ActiveRecord
    # track = Category.find(params...).tracks.create(track_params)
    track = Track.create(user_id: session[:user_id], category_id: params[:category_id], name: params[:title], order: params[:position])


    ## GROSS!
    # NO NO NON ONONONONO NONO NONON ONO ON ON ON ON ON ON ON ON ONNNONNOOOO
    # We have ActiveRecord for this purpose

    params[:course].each do |value, key|
      # more Activer Recorder
      # Course.find(..).coursetracks.create([{},{},{}])
      course = Course.find(key.to_i)
      CourseTrack.create(track: track, course: course)
    end
    UserTrack.create(track: track, user_id: session[:user_id])
    redirect_to track
  end

  def edit
    @track = Track.includes(:courses, :category => :courses).find(params[:id])
    @checked_courses = @track.courses


    ## GROSS!!!!!
    #
    # You could totally use something like......
    # @track.category.courses.where(checked: false)
    #
    # This is /massively/ inefficient.  YOu have to do 2 DB calls and then ask
    # ruby to calculate the difference.  the database is /designed/ to do
    # exactly that.  you are fighting against the databases nature (remember
    # day 2?)

    @all_courses = @track.category.courses - @checked_courses
    if session[:user_id] != @track.user_id
      redirect_to @track
    end
  end

  def update
    track = Track.find(params[:id])
    # Seems suspicious....
    # Why 2, why not 3, why not 900?
    # Or you might want to use DB constraints, Active Record validations or
    # JavaScript to defend this parameter?

    track.update(name: params[:title]) if params[:title].length > 2
    courses = params[:course].map{|value, key| value.to_i }
    track.courses = Course.find(courses)
    track.save
    redirect_to track
  end

  def follow
    UserTrack.create(user_id: session[:user_id], track_id: params[:track_id])
    redirect_to tracks_path
  end


end
