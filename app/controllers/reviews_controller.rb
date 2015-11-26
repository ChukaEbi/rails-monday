class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    @restaurant.reviews << @review
    p current_user.reviewed_restaurants
    redirect_to restaurants_path

  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to root_path
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end


end
