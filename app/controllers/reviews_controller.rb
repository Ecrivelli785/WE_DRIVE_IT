class ReviewsController < ApplicationController

  def new
    @ride = Ride.find(params[:ride_id])
    @review = Review.new
    authorize @review
  end

  def create
    @ride = Ride.find(params[:ride_id])
    @review = Review.new(review_params)
    @review.ride = @ride
    authorize @review
    if @review.save
      flash[:notice] = "Thanks for your review!"
      redirect_to root_path
    else
      render 'rides/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

# DOnde cree el form se tiene que pasar el @review =Review.new

