class ReviewsController < ActionController::Base

  def index
    @course = Course.find(params[:course_id])
    @reviews = @course.reviews
    @review = Review.new

  end

  def show
    @review = Review.find(params[:id])
  end

  def edit

  end

  def create
    
    course = Course.find(params[:course_id])
    review = course.reviews.new(review_params)
    if review.save
      redirect_to :back
    else
      redirect_to new_review_path
    end
    
  end

  def new
    @review = Review.new
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :difficulty, :rating)
  end
  
end
