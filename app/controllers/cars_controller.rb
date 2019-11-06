class CarsController < ApplicationController
  def index
    @cars = Car.all
  end
  def show
    @car = Car.show
  end
  def new
    @car = Car.new
  end
  def create
    @car = Car.new(car_params)
  end





end
