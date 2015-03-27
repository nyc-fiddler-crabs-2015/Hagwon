class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
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
    render text: 'saved'
  end


end