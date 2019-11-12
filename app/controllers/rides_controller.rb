class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :status]

  def index
    @rides = policy_scope(Ride).order(created_at: :desc)
  end

  def show
    if current_user.role == "passenger"
      render "rides/show"
    else
      render "rides/driver_show"
    end
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
    @ride.total_time_ride = TripHelper::get_travel_time(@ride.steps.first.coordinates, @ride.steps.last.coordinates)
    @ride.estimated_price = @ride.total_time_ride * @ride.service_type.price
    @ride.user = current_user
    authorize @ride
    if @ride.save
      redirect_to ride_path(@ride)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ride.update(status_params)
      redirect_to ride_path(@ride)
    else
      render :edit
    end
  end

  def status
    @ride = Ride.find(params[:id])
    redirect_to new_ride_payment_path(@ride) if @ride.completed?
  end

  private

  def ride_params
    params.require(:ride).permit(:start_time, :end_time, :content, :service_type_id, :status, steps_attributes: [:address, :order])
  end

  def status_params
    params.permit(:status)
  end

  def set_ride
    @ride = Ride.find(params[:id])
    authorize @ride
  end
end
