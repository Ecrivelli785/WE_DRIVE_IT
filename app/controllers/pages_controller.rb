class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def dashboard
  # if condition
    @rides = Ride.where(status: "PENDIENTE")
    @myrides = current_user.rides.where(status: "VIAJE TERMINADO")
   end
end
