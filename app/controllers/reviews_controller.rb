class ReviewsController < ApplicationController
  def create
    @ride = Ride.find(params[:ride_id])
      @review = Review.new(review_params)
      @review.user = current_user
      if @review.save!
        flash[:success] = "Thanks for your review!"
        redirect_to ride_path(@ride)
      else
        render 'ride/show'
      end
      authorize @review
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

# DOnde cree el form se tiene que pasar el @review =Review.new
