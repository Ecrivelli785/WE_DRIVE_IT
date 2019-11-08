class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :status]

  def index
    @rides = policy_scope(Ride).order(created_at: :desc).geocoded
    authorize @ride
  end

  def show
  end

  def new
    @ride = Ride.new
    authorize @ride
  end

  def create
    @ride = Ride.new(ride_params)
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
    if @ride.update(ride_params)
      redirect_to rides_path
    else
      render :edit
    end
  end

  def status
  end

  private

  def ride_params
    params.require(:ride).permit(:origin, :destination, :start_time, :end_time, :content, :service_type_id)
  end

  def set_ride
    @ride = Ride.find(params[:id])
    authorize @ride
  end
end
