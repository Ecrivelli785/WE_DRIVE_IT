class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def dashboard
    @rides = Ride.all.where(status: 'pending')
    @myrides = Ride.where(user: current_user)
  end
end
