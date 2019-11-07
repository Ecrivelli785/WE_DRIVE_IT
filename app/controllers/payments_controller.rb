class PaymentsController < ApplicationController
  protect_from_forgery except: :process_payment

  def new
    current_user.rides.where(status: 'pending').find(params[:ride_id])
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

  def process_payment
    @payment = Payment.new
    authorize @payment
    token = request.body.token
    payment_method_id = request.body.payment_method_id
    installments = request.body.installments
    issuer_id = request.body.issuer_id

    MercadoPago::SDK.access_token = "TEST-578709652964029-110719-15888f77f06cca21a069cab59d56cb34-47290988";

    payment = MercadoPago::Payment.new()
    payment.transaction_amount = 1
    payment.token = token
    payment.description = 'Mediocre Leather Computer'
    payment.installments = installments
    payment.payment_method_id = payment_method_id
    payment.issuer_id = issuer_id
    payment.payer = {
      email: "hernandezfeli@gmail.com"
    }
    # Guarda y postea el pago
    response = payment.save

    render :json => response
  end

  def add_card
    @payment = Payment.new
    authorize @payment
  end

private
  def payment_params
    params.require(:payment).permit(:params?)
  end
end
