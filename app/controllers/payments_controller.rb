class PaymentsController < ApplicationController
  protect_from_forgery except: [ :add_payment, :make_payment]

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

  def add_payment

    @payment = Payment.new
    authorize @payment

    # make a payment
    # if payment its ok, then
      # create a customer
      # save customer_id to user
      # add a card to the customer
      # save card_id to user

    token = params[:token]
    payment_method_id = params[:payment_method_id]
    installments = 1
    issuer_id = params[:issuer_id]


    $mp = MercadoPago.new("TEST-578709652964029-110719-15888f77f06cca21a069cab59d56cb34-47290988")

    payment = {}
    payment[:transaction_amount] = 1
    payment[:token] = token
    payment[:description] = 'Adding a new user to wedriveit'
    payment[:installments] = installments
    payment[:issuer_id] = issuer_id
    payment[:payer] = {
      email: current_user.email
    }

    payment_response = $mp.post("/v1/payments", payment)
    response = {}
    response[:payment_response] = payment_response

    if payment_response["status"] == "201"
      # create a customer
      customer_response = $mp.post("/v1/customers", {email: current_user.email})

      # save customer_id to user
      current_user.mp_customer_id = customer_response["response"]["id"]

      # add a card to the customer
      card_response = $mp.post("/v1/customers/#{customer_response["response"]["id"]}/cards", {token: token})

      current_user.mp_card_id = card_response["response"]["id"]
      current_user.save!
      # save card_id to user
      response[:customer_response] = customer_response
      response[:card_response] = card_response
    end

    render :json => response
  end

  def add_card
    @payment = Payment.new
    authorize @payment
  end

  def make_payment
    @payment = Payment.new
    authorize @payment
  end

  private

  def payment_params
    params.require(:payment).permit(:params?)
  end
end
