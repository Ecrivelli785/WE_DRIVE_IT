class PaymentsController < ApplicationController
  protect_from_forgery except: [:add_payment, :create]

  def failed
    authorize :payment, :failed?
  end

  def new
    @ride = Ride.find(params[:ride_id])
    authorize @ride
    @payment = Payment.new
    @payment.ride = @ride
    @review = Review.new
    # current_user.rides.where(status: 'pending').find(params[:ride_id])
  end

  def create
    @payment = Payment.new
    @payment.ride = @ride
    @ride = Ride.find(params[:ride_id])
    @payment.ride = @ride
    authorize @payment

    # create MP payment and save status
    require 'mercadopago'
    $mp = MercadoPago.new(ENV["MP_PRIVATE_TOKEN"])

    token = params[:token]
    payment_method_id = params[:payment_method_id]
    installments = 1
    issuer_id = params[:issuer_id]

    mp_payment = {}
    mp_payment[:transaction_amount] = @ride.estimated_price
    mp_payment[:token] = token
    mp_payment[:description] = 'Adding a new user to wedriveit'
    mp_payment[:installments] = installments
    mp_payment[:issuer_id] = issuer_id
    mp_payment[:payer] = {
      id: current_user.mp_customer_id
    }

    payment_response = $mp.post("/v1/payments", mp_payment)

    if payment_response["status"] == "201" && payment_response["response"]["status"] == "approved"
      @payment.ride = @ride
      if @payment.save!
        redirect_to new_ride_review_path(@ride)
      else
        render :new
      end
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

      require 'mercadopago'

      $mp = MercadoPago.new(ENV["MP_PRIVATE_TOKEN"])

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
      # check if customer exists
        search_customer_id = $mp.get("https://api.mercadopago.com/v1/customers/search?email=#{current_user.email}")
      if search_customer_id["response"]["results"].present?
        current_user.mp_card_id = search_customer_id["response"]["results"][0]["cards"][0]["id"]
        current_user.mp_customer_id = search_customer_id["response"]["results"][0]["id"]
        current_user.save
      else
        # create a customer
              # create a customer
        customer_response = $mp.post("/v1/customers", {email: current_user.email})
        # save customer_id to user
        current_user.mp_customer_id = customer_response["response"]["id"]
        # add a card to the customer
        card_response = $mp.post("/v1/customers/#{customer_response["response"]["id"]}/cards", {token: token})
        current_user.mp_card_id = card_response["response"]["id"]
        current_user.save
      end

      # # save customer_id to user

      # # add a card to the customer
      # card_response = $mp.post("/v1/customers/#{current_user.mp_customer_id}/cards", {token: token})

      # current_user.mp_card_id = card_response["response"]["id"]
      # current_user.save
      # # save card_id to user
      # response[:customer_response] = customer_response
      # response[:card_response] = card_response
    end
    redirect_to profile_path
  end
  def add_card
    skip_authorization
    if current_user.mp_card_id?
      return redirect_to ride_status_path(params[:ride_id])
    end
    @ride = Ride.find(params[:ride_id])
    @payment = Payment.new(ride: @ride)
    authorize @payment
  end

  private

  def payment_params
    params.require(:payment).permit(:params?)
  end
end
