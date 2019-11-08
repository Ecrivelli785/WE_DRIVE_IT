class PaymentsController < ApplicationController
  def new
    @ride = Ride.find(params[:ride_id])
    authorize @ride
    @payment = Payment.new
    @review = Review.new
    # current_user.rides.where(status: 'pending').find(params[:ride_id])
  end

  def create
    @payment = current_user.payments.new(payment_params)
    @payment.ride = Ride.find(params[:ride_id])
    authorize @payment
    if @payment.save
      redirect_to ride_path(@ride)
    else
      render :new
    end
  end

private
  def payment_params
    params.require(:payment).permit(:params?)
  end
end
