class CoursesController < ApplicationController
  def index
    @courses = Course.all
    # if request.xhr?

    #   courses = course.all.map{|cour| {id: cour.id, category: cour.category.name, url: cour.url, name: cour.user.name} }
    #   render :json => {courses: courses}
    # end

    respond_to do |format|
      format.html
      format.json
    end
  end