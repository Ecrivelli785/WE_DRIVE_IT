class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.all
  end

  def show
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.save
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to cars_path
    else
      render :edit
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :transmission, :poliza, :green_card, :fuel_type, :plate, :year)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
