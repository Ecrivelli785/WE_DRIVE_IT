class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update]

  def index
    @rides = Ride.all
  end

  def show
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.user = current_user
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

  private

  def ride_params
    params.require(:ride).permit(:origin, :destination, :start_time, :end_time, :content, :service_type_id)
  end

  def set_ride
    @ride = Ride.find(params[:id])
  end
end