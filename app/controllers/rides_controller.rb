class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_ride, only: [:show, :edit, :update, :status]

  def index
    @rides = policy_scope(Ride).order(created_at: :desc)
  end

  def show
  end

  def new
    @ride = Ride.new
    steps = 2
    if params[:service_type].present?
      @ride.service_type = ServiceType.find_by_name(params[:service_type])
      steps = @ride.service_type.name == ServiceType::OPTIONS[1] ? 2 : 3
    end
    steps.times do |order|
      @ride.steps.build(order: order + 1)
    end
    authorize @ride
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.save
    session[:ride_id] = @ride.id
    @ride.user = current_user if current_user.present?
    authorize @ride
    if @ride.save
      RideMailer.create_confirmation(@ride).deliver_now unless @ride.user.nil?
      redirect_to ride_path(@ride)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ride.status == "PENDIENTE"
      @ride.driver_id = current_user.id
      @ride.status = "ASIGNADO"
      @ride.save
      respond_to do |format|
        format.html { redirect_to ride_path(@ride) }
        format.js # <-- will render `app/views/rides/update.js.erb  `
      end
    else
      @ride.status = params[:ride][:status]
      @ride.save
      return redirect_to @ride
    end
  end

  def status
    @ride = Ride.find(params[:id])
    redirect_to new_ride_payment_path(@ride) if @ride.completed?
  end

  private

  def ride_params
    params.require(:ride).permit(:start_time, :end_time, :content, :service_type_id, :status, :estimated_time_ride, :estimated_price, steps_attributes: [:address, :order])
  end

  def set_ride
    @ride = Ride.find(params[:id])
    authorize @ride
  end
end
