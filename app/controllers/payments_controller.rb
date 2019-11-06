class PaymentsController < ApplicationController
  def new
    current_user.rides.where(status: 'pending').find(params[:ride_id])
  end

  def create
    @payment = Payment.new(payment_params)
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
