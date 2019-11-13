class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def dashboard
  #   @rides = Ride.all.where(status: 'pending')
  #   @myrides = Ride.where(driver_id: current_user.id)
    @rides = Ride.all
    @myrides = Ride.all
  end
end
