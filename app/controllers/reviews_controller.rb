class ReviewsController < ActionController::Base
  
  def index
    @course = Course.find(params[:course_id])
    @reviews = @course.reviews
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
     
  end

  def new
      
  end

  
end