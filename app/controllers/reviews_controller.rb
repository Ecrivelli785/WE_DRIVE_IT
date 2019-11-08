class ReviewsController < ApplicationController

# def new
# @review = Review.new
# end


  def create
    @ride = Ride.find(params[:ride_id])
      @review = Review.new(review_params)
      @review.user = current_user
       authorize @review
      if @review.save!
        flash[:success] = "Thanks for your review!"
        redirect_to ride_path(@ride)
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
